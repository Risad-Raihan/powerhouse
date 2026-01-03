import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../../core/database/app_database.dart';
import '../../core/utils/time_utils.dart';
import '../prayer/prayer_repository.dart';
import '../reading/reading_repository.dart';
import '../capture/capture_repository.dart';
import '../gamification/gamification_repository.dart';
import '../insights/insights_repository.dart';
import 'dashboard_models.dart';

/// Dashboard service
/// Read-only, reactive query layer for dashboard data
/// Composes module repository streams into a single DashboardData stream
class DashboardService {
  final PrayerRepository _prayerRepository;
  final ReadingRepository _readingRepository;
  final CaptureRepository _captureRepository;
  final GamificationRepository _gamificationRepository;
  final InsightsRepository _insightsRepository;

  static const String _timezone = 'Asia/Dhaka';
  static const int _recentCapturesLimit = 10;

  DashboardService({
    required PrayerRepository prayerRepository,
    required ReadingRepository readingRepository,
    required CaptureRepository captureRepository,
    required GamificationRepository gamificationRepository,
    required InsightsRepository insightsRepository,
  })  : _prayerRepository = prayerRepository,
        _readingRepository = readingRepository,
        _captureRepository = captureRepository,
        _gamificationRepository = gamificationRepository,
        _insightsRepository = insightsRepository;

  /// Watch dashboard data reactively
  /// Emits a new DashboardData whenever:
  /// - Time ticks (every 60 seconds)
  /// - Any underlying repository stream emits
  /// - Day boundary crosses (midnight in Asia/Dhaka)
  Stream<DashboardData> watchDashboard() {
    // Time stream: emit immediately, then every 60 seconds
    //
    // IMPORTANT: this stream is listened to multiple times downstream (directly and via derived streams),
    // so it MUST be broadcast/shared. Otherwise we'll crash with:
    // "Bad state: Stream has already been listened to."
    final nowUtc$ = Stream<DateTime>.value(nowUtc()).concatWith([
      Stream<DateTime>.periodic(
        const Duration(minutes: 1),
        (_) => nowUtc(),
      ),
    ]).publishReplay(maxSize: 1).refCount();

    // Derive local date (midnight in Asia/Dhaka) from UTC time
    //
    // Also shared: it is used as input to multiple day-scoped streams + combined output.
    final localDate$ = nowUtc$
        .map((utc) => utcToLocalMidnight(utc, timezone: _timezone))
        .distinct()
        .publishReplay(maxSize: 1)
        .refCount();

    // Day-scoped streams: rebind when localDate changes
    final todaysPrayers$ = localDate$.switchMap((localDate) {
      return _prayerRepository.watchTodayPrayers(localDate);
    });

    final todayReadingSessions$ = localDate$.switchMap((localDate) {
      return _readingRepository.watchTodayReadingSessions(localDate);
    });

    final todayXp$ = localDate$.switchMap((localDate) {
      return _gamificationRepository.watchTodayXp(localDate);
    });

    // Time-scoped streams: rebind when nowUtc changes (for expiry checks)
    final activeInsights$ = nowUtc$.switchMap((nowUtc) {
      return _insightsRepository.watchActiveInsights(nowUtc);
    });

    // Non-scoped streams: watch directly
    final currentReading$ = _readingRepository.watchCurrentReading();
    final recentCaptures$ = _captureRepository.watchRecentCaptures(_recentCapturesLimit);
    final totalXp$ = _gamificationRepository.watchTotalXp();

    // Combine all streams into one DashboardData stream
    // Emits whenever ANY upstream stream emits
    // Use nested combineLatest since we have 9 streams
    final partial$ = Rx.combineLatest8(
      nowUtc$,
      localDate$,
      todaysPrayers$,
      currentReading$,
      todayReadingSessions$,
      recentCaptures$,
      todayXp$,
      totalXp$,
      (
        DateTime nowUtc,
        DateTime localDate,
        List<PrayerEntry> todaysPrayers,
        ReadingItem? currentReading,
        List<ReadingSession> todayReadingSessions,
        List<CaptureItem> recentCaptures,
        int todayXp,
        int totalXp,
      ) {
        // Return a tuple-like object that we'll combine with activeInsights$
        return _DashboardDataPartial(
          nowUtc: nowUtc,
          localDate: localDate,
          todaysPrayers: todaysPrayers,
          currentReading: currentReading,
          todayReadingSessions: todayReadingSessions,
          recentCaptures: recentCaptures,
          todayXp: todayXp,
          totalXp: totalXp,
        );
      },
    );

    return Rx.combineLatest2(
      partial$,
      activeInsights$,
      (_DashboardDataPartial partial, List<InsightEntry> activeInsights) {
        return DashboardData(
          nowUtc: partial.nowUtc,
          timezone: _timezone,
          localDate: partial.localDate,
          todaysPrayers: partial.todaysPrayers,
          currentReading: partial.currentReading,
          todayReadingSessions: partial.todayReadingSessions,
          recentCaptures: partial.recentCaptures,
          todayXp: partial.todayXp,
          totalXp: partial.totalXp,
          activeInsights: activeInsights,
        );
      },
    );
  }
}

/// Helper class to hold partial dashboard data during stream combination
class _DashboardDataPartial {
  final DateTime nowUtc;
  final DateTime localDate;
  final List<PrayerEntry> todaysPrayers;
  final ReadingItem? currentReading;
  final List<ReadingSession> todayReadingSessions;
  final List<CaptureItem> recentCaptures;
  final int todayXp;
  final int totalXp;

  _DashboardDataPartial({
    required this.nowUtc,
    required this.localDate,
    required this.todaysPrayers,
    required this.currentReading,
    required this.todayReadingSessions,
    required this.recentCaptures,
    required this.todayXp,
    required this.totalXp,
  });
}

