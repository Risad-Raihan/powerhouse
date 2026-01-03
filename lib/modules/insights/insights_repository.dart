import 'package:drift/drift.dart';
import '../../core/database/app_database.dart';

/// Insights module repository
/// Provides query methods for rule-based insights (v1) and LLM insights (v2)
class InsightsRepository {
  final AppDatabase _db;

  InsightsRepository(this._db);

  /// Get active insights (not expired)
  /// An insight is active if expiresAtUtc is null or expiresAtUtc > nowUtc
  Future<List<InsightEntry>> getActiveInsights(DateTime nowUtc) async {
    final query = _db.select(_db.insightEntries)
      ..where((i) =>
          (i.expiresAtUtc.isNull()) | (i.expiresAtUtc.isBiggerThanValue(nowUtc)))
      ..orderBy([(i) => OrderingTerm.desc(i.generatedAtUtc)]);
    return await query.get();
  }

  /// Watch active insights (not expired) (reactive)
  /// An insight is active if expiresAtUtc is null or expiresAtUtc > nowUtc
  Stream<List<InsightEntry>> watchActiveInsights(DateTime nowUtc) {
    final query = _db.select(_db.insightEntries)
      ..where((i) =>
          (i.expiresAtUtc.isNull()) | (i.expiresAtUtc.isBiggerThanValue(nowUtc)))
      ..orderBy([(i) => OrderingTerm.desc(i.generatedAtUtc)]);
    return query.watch();
  }
}

