import 'dart:async';
import '../../core/database/app_database.dart';
import '../../core/utils/time_utils.dart';

/// Gamification module repository
/// Provides query methods for XP tracking
class GamificationRepository {
  final AppDatabase _db;

  GamificationRepository(this._db);

  /// Get total XP earned today (for a specific local date)
  Future<int> getTodayXp(String localDate) async {
    final events = await (_db.select(_db.xpEvents)
          ..where((e) => e.localDate.equals(localDate)))
        .get();
    return events.fold<int>(0, (sum, event) => sum + event.xp);
  }

  /// Get total XP earned across all time
  Future<int> getTotalXp() async {
    final events = await _db.select(_db.xpEvents).get();
    return events.fold<int>(0, (sum, event) => sum + event.xp);
  }

  /// Watch total XP earned today (for a specific local date) (reactive)
  Stream<int> watchTodayXp(DateTime localDate) {
    // Convert DateTime to ISO YYYY-MM-DD string
    final localDateStr = utcToLocalDate(localDate, 'Asia/Dhaka');
    final query = _db.select(_db.xpEvents)
      ..where((e) => e.localDate.equals(localDateStr));
    return query.watch().map((events) {
      return events.fold<int>(0, (sum, event) => sum + event.xp);
    });
  }

  /// Watch total XP earned across all time (reactive)
  Stream<int> watchTotalXp() {
    return _db.select(_db.xpEvents).watch().map((events) {
      return events.fold<int>(0, (sum, event) => sum + event.xp);
    });
  }
}

