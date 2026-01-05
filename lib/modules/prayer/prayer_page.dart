import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/database/app_database.dart';
import '../../core/utils/time_utils.dart';
import '../../core/theme/powerhouse_colors.dart';
import 'prayer_repository.dart';
import 'prayer_times_service.dart';
import 'prayer_times_card.dart';
import 'daily_prayer_tracker.dart';
import 'prayer_streak_card.dart';
import 'monthly_prayer_calendar.dart';

/// Prayer page - main prayer tracking interface
/// Shows prayer times, daily tracker, streak, and monthly calendar
class PrayerPage extends StatefulWidget {
  final PrayerRepository repository;

  const PrayerPage({
    super.key,
    required this.repository,
  });

  @override
  State<PrayerPage> createState() => _PrayerPageState();
}

class _PrayerPageState extends State<PrayerPage> {
  final PrayerTimesService _prayerTimesService = PrayerTimesService();
  final BehaviorSubject<List<PrayerTime>?> _prayerTimesSubject =
      BehaviorSubject<List<PrayerTime>?>();
  final BehaviorSubject<DateTime> _nowSubject =
      BehaviorSubject<DateTime>.seeded(nowUtc());
  Timer? _timeTimer;

  @override
  void initState() {
    super.initState();
    _loadPrayerTimes();
    _startTimeUpdates();
  }

  @override
  void dispose() {
    _timeTimer?.cancel();
    _prayerTimesSubject.close();
    _nowSubject.close();
    super.dispose();
  }

  Future<void> _loadPrayerTimes() async {
    try {
      final now = nowUtc();
      final localDate = utcToLocalMidnight(now);
      final prayerTimes = await _prayerTimesService.fetchPrayerTimes(localDate);
      _prayerTimesSubject.add(prayerTimes);
    } catch (e) {
      _prayerTimesSubject.addError(e);
    }
  }

  void _startTimeUpdates() {
    // Update time every minute
    _timeTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _nowSubject.add(nowUtc());
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer'),
        backgroundColor: PowerHouseColors.prayerGreenMuted.withValues(alpha: 0.5),
      ),
      body: StreamBuilder<DateTime>(
        stream: _nowSubject,
        builder: (context, nowSnapshot) {
          final currentNow = nowSnapshot.data ?? now;
          final localDate = utcToLocalMidnight(currentNow);

          return StreamBuilder<List<PrayerEntry>>(
            stream: widget.repository.watchTodayPrayers(localDate),
            builder: (context, prayersSnapshot) {
              final todayPrayers = prayersSnapshot.data ?? [];

              return StreamBuilder<List<PrayerTime>?>(
                stream: _prayerTimesSubject,
                builder: (context, timesSnapshot) {
                  if (timesSnapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48,
                              color: PowerHouseColors.error,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Unable to load prayer times',
                              style: textTheme.titleMedium?.copyWith(
                                color: PowerHouseColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              timesSnapshot.error.toString(),
                              style: textTheme.bodySmall?.copyWith(
                                color: PowerHouseColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (!timesSnapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final prayerTimes = timesSnapshot.data!;

                  return FutureBuilder<Map<String, int>>(
                    future: widget.repository.getStrictStreak(),
                    builder: (context, streakSnapshot) {
                      final streakData = streakSnapshot.data ?? {'current': 0, 'best': 0};

                      return FutureBuilder<Map<String, String>>(
                        future: widget.repository.getMonthPrayerStatus(
                          localDate.year,
                          localDate.month,
                        ),
                        builder: (context, calendarSnapshot) {
                          final monthStatus =
                              calendarSnapshot.data ?? <String, String>{};

                          return SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header with date and location
                                _buildHeader(context, localDate, textTheme),
                                const SizedBox(height: 24),

                                // Today's Prayer Times
                                PrayerTimesCard(
                                  prayerTimes: prayerTimes,
                                  now: currentNow,
                                ),
                                const SizedBox(height: 24),

                                // Daily Prayer Tracker
                                DailyPrayerTracker(
                                  todayPrayers: todayPrayers,
                                  repository: widget.repository,
                                ),
                                const SizedBox(height: 24),

                                // Prayer Streak
                                PrayerStreakCard(
                                  currentStreak: streakData['current'] ?? 0,
                                  bestStreak: streakData['best'] ?? 0,
                                ),
                                const SizedBox(height: 24),

                                // Monthly Calendar
                                MonthlyPrayerCalendar(
                                  monthStatus: monthStatus,
                                  year: localDate.year,
                                  month: localDate.month,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    DateTime localDate,
    TextTheme textTheme,
  ) {
    final monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final weekdayNames = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    final dateStr =
        '${weekdayNames[localDate.weekday - 1]}, ${monthNames[localDate.month - 1]} ${localDate.day}, ${localDate.year}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateStr,
          style: textTheme.headlineSmall?.copyWith(
            color: PowerHouseColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.location_on,
              size: 16,
              color: PowerHouseColors.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              'Dhaka, Bangladesh',
              style: textTheme.bodyMedium?.copyWith(
                color: PowerHouseColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
