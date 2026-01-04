import 'package:drift/drift.dart';
import '../../core/database/app_database.dart';
import '../../core/utils/time_utils.dart';

/// Reading module repository
/// Provides query methods for reading tracking
class ReadingRepository {
  final AppDatabase _db;

  ReadingRepository(this._db);

  /// Get the current reading item (most recent non-archived)
  Future<ReadingItem?> getCurrentReadingItem() async {
    final query = _db.select(_db.readingItems)
      ..where((r) => r.isArchived.equals(false))
      ..orderBy([(r) => OrderingTerm.desc(r.addedAtUtc)])
      ..limit(1);
    return await query.getSingleOrNull();
  }

  /// Get all reading sessions for a specific local date
  Future<List<ReadingSession>> getTodayReadingSessions(String localDate) async {
    final query = _db.select(_db.readingSessions)
      ..where((s) => s.localDate.equals(localDate))
      ..orderBy([(s) => OrderingTerm.desc(s.createdAtUtc)]);
    return await query.get();
  }

  /// Get the most recent reading session
  Future<ReadingSession?> getLastReadingSession() async {
    final query = _db.select(_db.readingSessions)
      ..orderBy([(s) => OrderingTerm.desc(s.createdAtUtc)])
      ..limit(1);
    return await query.getSingleOrNull();
  }

  /// Watch the current reading item (most recent non-archived) (reactive)
  Stream<ReadingItem?> watchCurrentReading() {
    final query = _db.select(_db.readingItems)
      ..where((r) => r.isArchived.equals(false))
      ..orderBy([(r) => OrderingTerm.desc(r.addedAtUtc)])
      ..limit(1);
    return query.watchSingleOrNull();
  }

  /// Watch all reading sessions for a specific local date (reactive)
  Stream<List<ReadingSession>> watchTodayReadingSessions(DateTime localDate) {
    // Convert DateTime to ISO YYYY-MM-DD string
    final localDateStr = utcToLocalDate(localDate, 'Asia/Dhaka');
    final query = _db.select(_db.readingSessions)
      ..where((s) => s.localDate.equals(localDateStr))
      ..orderBy([(s) => OrderingTerm.desc(s.createdAtUtc)]);
    return query.watch();
  }

  /// Watch all non-archived reading items (reactive)
  Stream<List<ReadingItem>> watchAllReadingItems() {
    final query = _db.select(_db.readingItems)
      ..where((r) => r.isArchived.equals(false))
      ..orderBy([(r) => OrderingTerm.desc(r.addedAtUtc)]);
    return query.watch();
  }

  /// Watch reading sessions within a date range (by localDate)
  /// startDate and endDate are ISO YYYY-MM-DD strings
  Stream<List<ReadingSession>> watchReadingSessionsInRange(
    String startDate,
    String endDate,
  ) {
    final query = _db.select(_db.readingSessions)
      ..where((s) => s.localDate.isBiggerOrEqualValue(startDate))
      ..where((s) => s.localDate.isSmallerOrEqualValue(endDate))
      ..orderBy([(s) => OrderingTerm.desc(s.createdAtUtc)]);
    return query.watch();
  }

  /// Watch all reading sessions (for computing per-item progress and last-read)
  Stream<List<ReadingSession>> watchAllReadingSessions() {
    final query = _db.select(_db.readingSessions)
      ..orderBy([(s) => OrderingTerm.desc(s.createdAtUtc)]);
    return query.watch();
  }
}

