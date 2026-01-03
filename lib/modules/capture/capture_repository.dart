import 'package:drift/drift.dart';
import '../../core/database/app_database.dart';

/// Capture module repository
/// Provides query methods for notes, thoughts, ideas, quotes
class CaptureRepository {
  final AppDatabase _db;

  CaptureRepository(this._db);

  /// Get recent captures, ordered by creation time (most recent first)
  Future<List<CaptureItem>> getRecentCaptures(int limit) async {
    final query = _db.select(_db.captureItems)
      ..orderBy([(c) => OrderingTerm.desc(c.createdAtUtc)])
      ..limit(limit);
    return await query.get();
  }

  /// Watch recent captures, ordered by creation time (most recent first) (reactive)
  Stream<List<CaptureItem>> watchRecentCaptures(int limit) {
    final query = _db.select(_db.captureItems)
      ..orderBy([(c) => OrderingTerm.desc(c.createdAtUtc)])
      ..limit(limit);
    return query.watch();
  }
}

