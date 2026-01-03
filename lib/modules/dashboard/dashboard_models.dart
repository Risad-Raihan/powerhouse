import '../../core/database/app_database.dart';

/// Dashboard domain model
/// Immutable data container for dashboard state
/// No logic, no UI imports, pure Dart
class DashboardData {
  final DateTime nowUtc;
  final String timezone;
  final DateTime localDate;

  final List<PrayerEntry> todaysPrayers;

  final ReadingItem? currentReading;
  final List<ReadingSession> todayReadingSessions;

  final List<CaptureItem> recentCaptures;

  final int todayXp;
  final int totalXp;

  final List<InsightEntry> activeInsights;

  const DashboardData({
    required this.nowUtc,
    required this.timezone,
    required this.localDate,
    required this.todaysPrayers,
    required this.currentReading,
    required this.todayReadingSessions,
    required this.recentCaptures,
    required this.todayXp,
    required this.totalXp,
    required this.activeInsights,
  });
}

