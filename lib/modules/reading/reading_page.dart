import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/database/app_database.dart';
import '../../core/utils/time_utils.dart';
import '../../core/theme/theme_extensions.dart';
import 'reading_repository.dart';
import 'reading_stats_section.dart';
import 'reading_library_grid.dart';

/// View model for ReadingPage
/// Contains all data needed to render the page
class ReadingPageVm {
  final ReadingItem? currentReading;
  final double? currentReadingProgress; // 0.0 to 1.0, null if not computable
  final ReadingPeriodStats weekStats;
  final ReadingPeriodStats monthStats;
  final ReadingPeriodStats yearStats;
  final List<ReadingItemTileModel> libraryItems;

  ReadingPageVm({
    required this.currentReading,
    required this.currentReadingProgress,
    required this.weekStats,
    required this.monthStats,
    required this.yearStats,
    required this.libraryItems,
  });
}

/// Stats for a time period
class ReadingPeriodStats {
  final int sessionsCount;
  final int totalMinutes;
  final double progressValue; // activeDays / periodDays

  ReadingPeriodStats({
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
    final currentReading$ = readingRepository.watchCurrentReading();
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
    return Rx.combineLatest7(
      currentReading$,
      allItems$,
      allSessions$,
      localDate$,
      weekSessions$,
      monthSessions$,
      yearSessions$,
      (
        ReadingItem? currentReading,
        List<ReadingItem> allItems,
        List<ReadingSession> allSessions,
        DateTime localDate,
        List<ReadingSession> weekSessions,
        List<ReadingSession> monthSessions,
        List<ReadingSession> yearSessions,
      ) {
        // Compute current reading progress
        double? currentProgress;
        if (currentReading != null &&
            currentReading.totalUnits != null &&
            currentReading.totalUnits! > 0) {
          final itemSessions = allSessions
              .where((s) => s.readingItemId == currentReading.id)
              .where((s) => s.progressUnits != null)
              .toList();
          final totalProgressUnits = itemSessions
              .map((s) => s.progressUnits!)
              .fold<int>(0, (sum, units) => sum + units);
          if (totalProgressUnits > 0) {
            currentProgress =
                (totalProgressUnits / currentReading.totalUnits!).clamp(0.0, 1.0);
          }
        }

        // Compute stats
        final weekStats = _computePeriodStats(weekSessions, 7);
        final monthStats = _computePeriodStats(monthSessions, 30);
        final yearStats = _computeYearStats(yearSessions, localDate.year);

        // Compute library tile models
        final libraryItems = allItems.map((item) {
          return _computeTileModel(item, allSessions, timezone);
        }).toList();

        return ReadingPageVm(
          currentReading: currentReading,
          currentReadingProgress: currentProgress,
          weekStats: weekStats,
          monthStats: monthStats,
          yearStats: yearStats,
          libraryItems: libraryItems,
        );
      },
    );
  }

  ReadingPeriodStats _computePeriodStats(
    List<ReadingSession> sessions,
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
      sessionsCount: sessionsCount,
      totalMinutes: totalMinutes,
      progressValue: progressValue,
    );
  }

  ReadingPeriodStats _computeYearStats(
    List<ReadingSession> sessions,
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
          // Current Reading Section
          _buildCurrentReadingSection(
            context,
            vm.currentReading,
            vm.currentReadingProgress,
            tokens,
            textTheme,
            colorScheme,
          ),
          const SizedBox(height: 16),

          // Reading Stats Section
          ReadingStatsSection(
            weekStats: vm.weekStats,
            monthStats: vm.monthStats,
            yearStats: vm.yearStats,
          ),
          const SizedBox(height: 16),

          // Library Section
          Text(
            'Library',
            style: textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          ReadingLibraryGrid(items: vm.libraryItems),
          const SizedBox(height: 16),

          // Reader Entry Button
          Center(
            child: FilledButton(
              onPressed: () {
                // TODO: Navigate to Reader Mode
              },
              child: const Text('Open Reader'),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCurrentReadingSection(
    BuildContext context,
    ReadingItem? currentReading,
    double? progress,
    PowerHouseCardTokens tokens,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Card(
      elevation: tokens.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.radius),
      ),
      child: Padding(
        padding: tokens.padding,
        child: currentReading == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Reading',
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No active reading',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Reading',
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    currentReading.title,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (currentReading.author != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      currentReading.author!,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      // TODO: Navigate to Reader Mode for currentReading
                    },
                    child: const Text('Continue Reading'),
                  ),
                ],
              ),
      ),
    );
  }
}
