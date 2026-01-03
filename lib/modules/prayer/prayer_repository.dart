import 'package:drift/drift.dart';
import '../../core/database/app_database.dart';
import '../../core/database/converters/enum_converters.dart';
import '../../core/utils/time_utils.dart';

/// Prayer module repository
/// Provides query methods for prayer tracking
class PrayerRepository {
  final AppDatabase _db;

  PrayerRepository(this._db);

  /// Get all prayers for a specific local date
  Future<List<PrayerEntry>> getTodayPrayers(String localDate) async {
    final query = _db.select(_db.prayerEntries)
      ..where((p) => p.localDate.equals(localDate));
    return await query.get();
  }

  /// Watch all prayers for a specific local date (reactive)
  Stream<List<PrayerEntry>> watchTodayPrayers(DateTime localDate) {
    // Convert DateTime to ISO YYYY-MM-DD string
    final localDateStr = utcToLocalDate(localDate, 'Asia/Dhaka');
    final query = _db.select(_db.prayerEntries)
      ..where((p) => p.localDate.equals(localDateStr));
    return query.watch();
  }

  /// Upsert a prayer entry
  /// Honors UNIQUE(localDate, prayer) constraint
  /// Returns the ID of the inserted/updated entry
  Future<int> upsertPrayerEntry({
    required PrayerType prayer,
    required PrayerStatus status,
    required DateTime loggedAtUtc,
    required String localDate,
    String timezone = 'Asia/Dhaka',
    String? note,
    int xpAwarded = 0,
  }) async {
    // Try to find existing entry
    final existing = await (_db.select(_db.prayerEntries)
          ..where((p) =>
              p.localDate.equals(localDate) & (p.prayer.equals(prayer.name))))
        .getSingleOrNull();

    final entry = PrayerEntriesCompanion(
      prayer: Value(prayer),
      status: Value(status),
      loggedAtUtc: Value(loggedAtUtc),
      localDate: Value(localDate),
      timezone: Value(timezone),
      note: Value(note),
      xpAwarded: Value(xpAwarded),
    );

    if (existing != null) {
      // Update existing entry
      await (_db.update(_db.prayerEntries)..where((p) => p.id.equals(existing.id)))
          .write(entry);
      return existing.id;
    } else {
      // Insert new entry
      return await _db.into(_db.prayerEntries).insert(entry);
    }
  }

  /// Get prayer streak for a specific prayer type
  /// Returns consecutive days with at least one entry of the given prayer type
  /// with status = prayed or prayedLate
  Future<int> getPrayerStreak(PrayerType prayerType) async {
    final allEntries = await (_db.select(_db.prayerEntries)
          ..where((p) =>
              (p.prayer.equals(prayerType.name)) &
              ((p.status.equals(PrayerStatus.prayed.name)) |
                  (p.status.equals(PrayerStatus.prayedLate.name))))
          ..orderBy([(p) => OrderingTerm.desc(p.localDate)]))
        .get();

    if (allEntries.isEmpty) {
      return 0;
    }

    // Get unique local dates, sorted descending
    final dates = allEntries.map((e) => e.localDate).toSet().toList()
      ..sort((a, b) => b.compareTo(a));

    // Calculate consecutive days starting from today
    int streak = 0;
    final today = dates.first; // Most recent date

    // Parse today's date
    final todayParts = today.split('-');
    var currentDate = DateTime(
      int.parse(todayParts[0]),
      int.parse(todayParts[1]),
      int.parse(todayParts[2]),
    );

    for (final dateStr in dates) {
      final dateParts = dateStr.split('-');
      final entryDate = DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
      );

      // Check if this entry is the expected next day in the streak
      final daysDiff = currentDate.difference(entryDate).inDays;
      if (daysDiff == 0) {
        streak++;
        currentDate = currentDate.subtract(const Duration(days: 1));
      } else if (daysDiff > 0) {
        // Gap found, streak broken
        break;
      }
    }

    return streak;
  }
}

