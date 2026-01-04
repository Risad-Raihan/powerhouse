import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/database/app_database.dart';
import '../../core/database/converters/enum_converters.dart';
import '../../core/utils/time_utils.dart';
import '../../core/theme/theme_extensions.dart';
import '../../core/theme/powerhouse_colors.dart';
import 'reading_repository.dart';
import 'reading_stats_section.dart';
import 'book_search/book_search_page.dart';

/// View model for ReadingPage
/// Contains all data needed to render the page
class ReadingPageVm {
  final ReadingPeriodStats weekStats;
  final ReadingPeriodStats monthStats;
  final ReadingPeriodStats yearStats;
  final List<ReadingItemTileModel> currentlyReadingItems;
  final List<ReadingItemTileModel> wantToReadItems;
  final List<ReadingItemTileModel> doneItems;
  final int doneBooksThisYear;
  final Map<int, int> doneByMonthForYear; // month (1-12) -> count

  ReadingPageVm({
    required this.weekStats,
    required this.monthStats,
    required this.yearStats,
    required this.currentlyReadingItems,
    required this.wantToReadItems,
    required this.doneItems,
    required this.doneBooksThisYear,
    required this.doneByMonthForYear,
  });
}

/// Stats for a time period
class ReadingPeriodStats {
  final int readingCount; // Books currently being read in this period
  final int doneCount; // Books completed in this period
  final int sessionsCount;
  final int totalMinutes;
  final double progressValue; // activeDays / periodDays

  ReadingPeriodStats({
    required this.readingCount,
    required this.doneCount,
    required this.sessionsCount,
    required this.totalMinutes,
    required this.progressValue,
  });
}

/// Model for a library grid tile
class ReadingItemTileModel {
  final ReadingItem item;
  final double? progress; // 0.0 to 1.0, null if not computable
  final String? lastReadLabel; // e.g., "2 days ago" or null
  final int? rating; // 1-5, null if not rated

  ReadingItemTileModel({
    required this.item,
    required this.progress,
    required this.lastReadLabel,
    required this.rating,
  });
}

/// Reading page - Library & Stats overview
/// Tablet-first management screen for reading tracking
class ReadingPage extends StatelessWidget {
  final ReadingRepository readingRepository;

  const ReadingPage({
    super.key,
    required this.readingRepository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BookSearchPage(
                    readingRepository: readingRepository,
                  ),
                ),
              );
            },
            tooltip: 'Search & Add Books',
          ),
        ],
      ),
      body: StreamBuilder<ReadingPageVm>(
        stream: _buildCombinedStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading reading data: ${snapshot.error}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('No data available'),
            );
          }

          final vm = snapshot.data!;
          return _buildContent(context, vm);
        },
      ),
    );
  }

  Stream<ReadingPageVm> _buildCombinedStream() {
    const timezone = 'Asia/Dhaka';

    // Time stream: emit immediately, then every 60 seconds
    final nowUtc$ = Stream<DateTime>.value(nowUtc()).concatWith([
      Stream<DateTime>.periodic(
        const Duration(minutes: 1),
        (_) => nowUtc(),
      ),
    ]).publishReplay(maxSize: 1).refCount();

    // Derive local date (midnight in Asia/Dhaka)
    final localDate$ = nowUtc$
        .map((utc) => utcToLocalMidnight(utc, timezone: timezone))
        .distinct()
        .publishReplay(maxSize: 1)
        .refCount();

    // Watch streams
    final allItems$ = readingRepository.watchAllReadingItems();
    final allSessions$ = readingRepository.watchAllReadingSessions();

    // Date range streams: rebind when localDate changes
    final weekSessions$ = localDate$.switchMap((localDate) {
      final endDate = utcToLocalDate(localDate, timezone);
      final startDate = _subtractDays(endDate, 7);
      return readingRepository.watchReadingSessionsInRange(startDate, endDate);
    });

    final monthSessions$ = localDate$.switchMap((localDate) {
      final endDate = utcToLocalDate(localDate, timezone);
      final startDate = _subtractDays(endDate, 30);
      return readingRepository.watchReadingSessionsInRange(startDate, endDate);
    });

    final yearSessions$ = localDate$.switchMap((localDate) {
      final endDate = utcToLocalDate(localDate, timezone);
      final yearStart = '${localDate.year}-01-01';
      return readingRepository.watchReadingSessionsInRange(yearStart, endDate);
    });

    // Combine all streams
    return Rx.combineLatest6(
      allItems$,
      allSessions$,
      localDate$,
      weekSessions$,
      monthSessions$,
      yearSessions$,
      (
        List<ReadingItem> allItems,
        List<ReadingSession> allSessions,
        DateTime localDate,
        List<ReadingSession> weekSessions,
        List<ReadingSession> monthSessions,
        List<ReadingSession> yearSessions,
      ) {
        // Compute DONE and READING counts for periods
        final weekDoneCount = _computeDoneCount(allItems, localDate, days: 7);
        final weekReadingCount = _computeReadingCount(allItems, localDate, days: 7);
        final monthDoneCount = _computeDoneCount(allItems, localDate, days: 30);
        final monthReadingCount = _computeReadingCount(allItems, localDate, days: 30);
        final yearDoneCount = _computeDoneCount(allItems, localDate, year: localDate.year);
        final doneByMonth = _computeDoneByMonth(allItems, localDate.year);

        // Compute stats
        final weekStats = _computePeriodStats(weekSessions, weekReadingCount, weekDoneCount, 7);
        final monthStats = _computePeriodStats(monthSessions, monthReadingCount, monthDoneCount, 30);
        final yearStats = _computeYearStats(yearSessions, 0, yearDoneCount, localDate.year);

        // Group items by status
        final currentlyReadingItems = <ReadingItemTileModel>[];
        final wantToReadItems = <ReadingItemTileModel>[];
        final doneItems = <ReadingItemTileModel>[];

        for (final item in allItems) {
          final tileModel = _computeTileModel(item, allSessions, timezone);
          final status = item.status;
          
          switch (status) {
            case ReadingStatus.currentlyReading:
              currentlyReadingItems.add(tileModel);
              break;
            case ReadingStatus.wantToRead:
              wantToReadItems.add(tileModel);
              break;
            case ReadingStatus.done:
              doneItems.add(tileModel);
              break;
          }
        }

        // Sort done items by completedAtUtc DESC
        doneItems.sort((a, b) {
          final aDate = a.item.completedAtUtc;
          final bDate = b.item.completedAtUtc;
          if (aDate == null && bDate == null) return 0;
          if (aDate == null) return 1;
          if (bDate == null) return -1;
          return bDate.compareTo(aDate);
        });

        return ReadingPageVm(
          weekStats: weekStats,
          monthStats: monthStats,
          yearStats: yearStats,
          currentlyReadingItems: currentlyReadingItems,
          wantToReadItems: wantToReadItems,
          doneItems: doneItems,
          doneBooksThisYear: yearDoneCount,
          doneByMonthForYear: doneByMonth,
        );
      },
    );
  }

  int _computeDoneCount(
    List<ReadingItem> allItems,
    DateTime localDate, {
    int? days,
    int? year,
  }) {
    final now = nowUtc();
    final cutoffDate = days != null
        ? now.subtract(Duration(days: days))
        : year != null
            ? DateTime.utc(year, 1, 1)
            : null;

    return allItems.where((item) {
      if (item.status.name != 'done' || item.completedAtUtc == null) return false;
      if (cutoffDate == null) return true;
      return item.completedAtUtc!.isAfter(cutoffDate) ||
          item.completedAtUtc!.isAtSameMomentAs(cutoffDate);
    }).length;
  }

  int _computeReadingCount(
    List<ReadingItem> allItems,
    DateTime localDate, {
    int? days,
  }) {
    final now = nowUtc();
    final cutoffDate = days != null ? now.subtract(Duration(days: days)) : null;

    return allItems.where((item) {
      if (item.status.name != 'currentlyReading') return false;
      // Count items that were set to currentlyReading within the period
      if (cutoffDate == null) return true;
      return item.statusUpdatedAtUtc.isAfter(cutoffDate) ||
          item.statusUpdatedAtUtc.isAtSameMomentAs(cutoffDate);
    }).length;
  }

  Map<int, int> _computeDoneByMonth(List<ReadingItem> allItems, int year) {
    final doneByMonth = <int, int>{};
    for (int month = 1; month <= 12; month++) {
      doneByMonth[month] = 0;
    }

    for (final item in allItems) {
      if (item.status.name == 'done' && item.completedAtUtc != null) {
        final completed = item.completedAtUtc!;
        if (completed.year == year) {
          doneByMonth[completed.month] = (doneByMonth[completed.month] ?? 0) + 1;
        }
      }
    }

    return doneByMonth;
  }

  ReadingPeriodStats _computePeriodStats(
    List<ReadingSession> sessions,
    int readingCount,
    int doneCount,
    int periodDays,
  ) {
    final sessionsCount = sessions.length;
    final totalMinutes = sessions.fold<int>(
      0,
      (sum, s) => sum + s.durationMinutes,
    );

    // Count unique active days
    final activeDays = sessions.map((s) => s.localDate).toSet().length;
    final progressValue = (activeDays / periodDays).clamp(0.0, 1.0);

    return ReadingPeriodStats(
      readingCount: readingCount,
      doneCount: doneCount,
      sessionsCount: sessionsCount,
      totalMinutes: totalMinutes,
      progressValue: progressValue,
    );
  }

  ReadingPeriodStats _computeYearStats(
    List<ReadingSession> sessions,
    int readingCount,
    int doneCount,
    int year,
  ) {
    final sessionsCount = sessions.length;
    final totalMinutes = sessions.fold<int>(
      0,
      (sum, s) => sum + s.durationMinutes,
    );

    // Count unique active days
    final activeDays = sessions.map((s) => s.localDate).toSet().length;
    // Days elapsed in current year
    final now = DateTime.now();
    final yearStart = DateTime(year, 1, 1);
    final daysElapsed = now.difference(yearStart).inDays + 1;
    final progressValue = (activeDays / daysElapsed).clamp(0.0, 1.0);

    return ReadingPeriodStats(
      readingCount: readingCount,
      doneCount: doneCount,
      sessionsCount: sessionsCount,
      totalMinutes: totalMinutes,
      progressValue: progressValue,
    );
  }

  ReadingItemTileModel _computeTileModel(
    ReadingItem item,
    List<ReadingSession> allSessions,
    String timezone,
  ) {
    // Compute progress
    double? progress;
    if (item.totalUnits != null && item.totalUnits! > 0) {
      final itemSessions = allSessions
          .where((s) => s.readingItemId == item.id)
          .where((s) => s.progressUnits != null)
          .toList();
      final totalProgressUnits = itemSessions
          .map((s) => s.progressUnits!)
          .fold<int>(0, (sum, units) => sum + units);
      if (totalProgressUnits > 0) {
        progress = (totalProgressUnits / item.totalUnits!).clamp(0.0, 1.0);
      }
    }

    // Compute last read label
    final itemSessions = allSessions
        .where((s) => s.readingItemId == item.id)
        .toList();
    String? lastReadLabel;
    if (itemSessions.isNotEmpty) {
      final lastSession = itemSessions.first; // Already sorted desc by createdAtUtc
      final lastSessionDate = lastSession.createdAtUtc;
      final now = nowUtc();
      final daysDiff = now.difference(lastSessionDate).inDays;
      if (daysDiff == 0) {
        lastReadLabel = 'Today';
      } else if (daysDiff == 1) {
        lastReadLabel = 'Yesterday';
      } else if (daysDiff < 7) {
        lastReadLabel = '$daysDiff days ago';
      } else if (daysDiff < 30) {
        final weeks = (daysDiff / 7).floor();
        lastReadLabel = '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
      } else {
        final months = (daysDiff / 30).floor();
        lastReadLabel = '$months ${months == 1 ? 'month' : 'months'} ago';
      }
    }

    // Rating: null for now (not in schema yet)
    const rating = null;

    return ReadingItemTileModel(
      item: item,
      progress: progress,
      lastReadLabel: lastReadLabel,
      rating: rating,
    );
  }

  String _subtractDays(String dateStr, int days) {
    final parts = dateStr.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);
    final date = DateTime(year, month, day);
    final newDate = date.subtract(Duration(days: days));
    return '${newDate.year.toString().padLeft(4, '0')}-'
        '${newDate.month.toString().padLeft(2, '0')}-'
        '${newDate.day.toString().padLeft(2, '0')}';
  }

  Widget _buildContent(BuildContext context, ReadingPageVm vm) {
    final tokens = Theme.of(context).extension<PowerHouseCardTokens>();
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    if (tokens == null) {
      throw StateError('PowerHouseCardTokens not found in theme');
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(tokens.paddingSmall.horizontal / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Yearly Goal Section
          _buildYearlyGoalSection(context, vm.doneBooksThisYear, tokens, textTheme, colorScheme),
          const SizedBox(height: 16),

          // Reading Stats Section (Week & Month bar charts)
          ReadingStatsSection(
            weekStats: vm.weekStats,
            monthStats: vm.monthStats,
            yearStats: vm.yearStats, // Not displayed but kept for compatibility
          ),
          const SizedBox(height: 16),

          // Section A: Currently Reading (teal accent)
          _buildStatusSection(
            context,
            title: 'Currently Reading',
            items: vm.currentlyReadingItems,
            accentColor: PowerHouseColors.accentTeal,
            showProgress: true,
            showContinueButton: true,
            tokens: tokens,
            textTheme: textTheme,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 32),

          // Section B: Want to Read (violet accent)
          _buildStatusSection(
            context,
            title: 'Want to Read',
            items: vm.wantToReadItems,
            accentColor: PowerHouseColors.accentViolet,
            showProgress: false,
            showContinueButton: false,
            tokens: tokens,
            textTheme: textTheme,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 32),

          // Section C: Done Reading (amber/lime accent)
          _buildStatusSection(
            context,
            title: 'Done Reading',
            items: vm.doneItems,
            accentColor: PowerHouseColors.accentAmber,
            showProgress: false,
            showContinueButton: false,
            showCompletionDate: true,
            tokens: tokens,
            textTheme: textTheme,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildYearlyGoalSection(
    BuildContext context,
    int doneBooksThisYear,
    PowerHouseCardTokens tokens,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    const goal = 30;
    final progress = (doneBooksThisYear / goal).clamp(0.0, 1.0);

    return Card(
      elevation: tokens.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.radius),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(tokens.radius),
          gradient: LinearGradient(
            colors: [
              PowerHouseColors.accentViolet.withValues(alpha: 0.2),
              PowerHouseColors.accentTeal.withValues(alpha: 0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: tokens.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Yearly Reading Goal',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$doneBooksThisYear / $goal books',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${(progress * 100).toStringAsFixed(0)}%',
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 12,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    PowerHouseColors.accentViolet,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusSection(
    BuildContext context, {
    required String title,
    required List<ReadingItemTileModel> items,
    required Color accentColor,
    required bool showProgress,
    required bool showContinueButton,
    bool showCompletionDate = false,
    required PowerHouseCardTokens tokens,
    required TextTheme textTheme,
    required ColorScheme colorScheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: textTheme.titleLarge,
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (items.isEmpty)
          Padding(
            padding: EdgeInsets.all(tokens.paddingSmall.horizontal),
            child: Center(
              child: Text(
                'No items yet',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ),
          )
        else
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              if (constraints.maxWidth >= 1200) {
                crossAxisCount = 4;
              } else if (constraints.maxWidth >= 900) {
                crossAxisCount = 3;
              } else if (constraints.maxWidth >= 600) {
                crossAxisCount = 2;
              } else {
                crossAxisCount = 1;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: tokens.paddingSmall.horizontal / 2,
                  mainAxisSpacing: tokens.paddingSmall.horizontal / 2,
                  childAspectRatio: 0.55, // Reduced from 0.7 to give more height
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final model = items[index];
                  return _buildStatusItemCard(
                    context,
                    model: model,
                    accentColor: accentColor,
                    showProgress: showProgress,
                    showContinueButton: showContinueButton,
                    showCompletionDate: showCompletionDate,
                    tokens: tokens,
                    textTheme: textTheme,
                    colorScheme: colorScheme,
                  );
                },
              );
            },
          ),
      ],
    );
  }

  Widget _buildStatusItemCard(
    BuildContext context, {
    required ReadingItemTileModel model,
    required Color accentColor,
    required bool showProgress,
    required bool showContinueButton,
    required bool showCompletionDate,
    required PowerHouseCardTokens tokens,
    required TextTheme textTheme,
    required ColorScheme colorScheme,
  }) {
    return Card(
      elevation: tokens.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.radius),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to Reader Mode
        },
        borderRadius: BorderRadius.circular(tokens.radius),
        child: Padding(
          padding: EdgeInsets.all(tokens.paddingSmall.horizontal / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cover image placeholder
              AspectRatio(
                aspectRatio: 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: model.item.coverImagePath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: model.item.coverImagePath!.startsWith('http')
                              ? Image.network(
                                  model.item.coverImagePath!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return _buildPlaceholderIcon(context, colorScheme);
                                  },
                                )
                              : Image.asset(
                                  model.item.coverImagePath!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return _buildPlaceholderIcon(context, colorScheme);
                                  },
                                ),
                        )
                      : _buildPlaceholderIcon(context, colorScheme),
                ),
              ),
              const SizedBox(height: 6),

                  // Title
                  Text(
                    model.item.title,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),

                  // Author
                  if (model.item.author != null) ...[
                    Text(
                      model.item.author!,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                        fontSize: 10,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                  ],

                  // Progress bar (if enabled)
                  if (showProgress && model.progress != null) ...[
                    LinearProgressIndicator(
                      value: model.progress,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                      minHeight: 3,
                    ),
                    const SizedBox(height: 4),
                  ],

                  // Completion date (if enabled)
                  if (showCompletionDate && model.item.completedAtUtc != null) ...[
                    Text(
                      _formatCompletionDate(model.item.completedAtUtc!),
                      style: textTheme.labelSmall?.copyWith(
                        color: accentColor.withValues(alpha: 0.8),
                        fontSize: 9,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],

                  // Status actions and Continue Reading button
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Status change button - always visible
                      OutlinedButton.icon(
                        onPressed: () {
                          _showStatusChangeDialog(context, model.item);
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 14,
                        ),
                        label: Text(
                          _getStatusChangeLabel(model.item.status),
                          style: textTheme.labelSmall?.copyWith(
                            fontSize: 10,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      
                      // Continue Reading button (if enabled)
                      if (showContinueButton) ...[
                        const SizedBox(height: 4),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              // TODO: Navigate to Reader Mode
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: accentColor,
                              padding: EdgeInsets.symmetric(vertical: 6),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Continue Reading',
                              style: textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
          ),
        ),
      )
    ;
  }

  Widget _buildPlaceholderIcon(BuildContext context, ColorScheme colorScheme) {
    return Center(
      child: Icon(
        Icons.menu_book,
        size: 48,
        color: colorScheme.onSurface.withValues(alpha: 0.3),
      ),
    );
  }

  String _formatCompletionDate(DateTime completedAtUtc) {
    final now = nowUtc();
    final daysDiff = now.difference(completedAtUtc).inDays;
    
    if (daysDiff == 0) {
      return 'Completed today';
    } else if (daysDiff == 1) {
      return 'Completed yesterday';
    } else if (daysDiff < 7) {
      return 'Completed $daysDiff days ago';
    } else if (daysDiff < 30) {
      final weeks = (daysDiff / 7).floor();
      return 'Completed $weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else {
      // Format as date
      final year = completedAtUtc.year;
      final month = completedAtUtc.month;
      final day = completedAtUtc.day;
      return 'Completed $year-$month-$day';
    }
  }

  String _getStatusChangeLabel(ReadingStatus currentStatus) {
    switch (currentStatus) {
      case ReadingStatus.wantToRead:
        return 'Change Status';
      case ReadingStatus.currentlyReading:
        return 'Mark Done';
      case ReadingStatus.done:
        return 'Change Status';
    }
  }

  void _showStatusChangeDialog(BuildContext context, ReadingItem item) {
    final currentStatus = item.status;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Status: ${item.title}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (currentStatus == ReadingStatus.wantToRead) ...[
              ListTile(
                leading: const Icon(Icons.menu_book),
                title: const Text('Start Reading'),
                onTap: () {
                  Navigator.of(context).pop();
                  _handleStatusChange(context, item, ReadingStatus.currentlyReading);
                },
              ),
              ListTile(
                leading: const Icon(Icons.check_circle),
                title: const Text('Mark as Done'),
                onTap: () {
                  Navigator.of(context).pop();
                  _handleStatusChange(context, item, ReadingStatus.done);
                },
              ),
            ] else if (currentStatus == ReadingStatus.currentlyReading) ...[
              ListTile(
                leading: const Icon(Icons.check_circle),
                title: const Text('Mark as Done'),
                onTap: () {
                  Navigator.of(context).pop();
                  _handleStatusChange(context, item, ReadingStatus.done);
                },
              ),
              ListTile(
                leading: const Icon(Icons.book_outlined),
                title: const Text('Move to Want to Read'),
                onTap: () {
                  Navigator.of(context).pop();
                  _handleStatusChange(context, item, ReadingStatus.wantToRead);
                },
              ),
            ] else if (currentStatus == ReadingStatus.done) ...[
              ListTile(
                leading: const Icon(Icons.menu_book),
                title: const Text('Move to Currently Reading'),
                onTap: () {
                  Navigator.of(context).pop();
                  _handleStatusChange(context, item, ReadingStatus.currentlyReading);
                },
              ),
              ListTile(
                leading: const Icon(Icons.book_outlined),
                title: const Text('Move to Want to Read'),
                onTap: () {
                  Navigator.of(context).pop();
                  _handleStatusChange(context, item, ReadingStatus.wantToRead);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _handleStatusChange(BuildContext context, ReadingItem item, ReadingStatus newStatus) {
    readingRepository.updateReadingStatus(
      id: item.id,
      newStatus: newStatus,
      nowUtc: nowUtc(),
    ).then((_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Status updated'),
          ),
        );
      }
    }).catchError((error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update status: $error'),
          ),
        );
      }
    });
  }
}
