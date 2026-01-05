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

  /// Get strict prayer streak
  /// Day counts ONLY if ALL 5 prayers are completed (status = prayed or prayedLate)
  /// Missing even one prayer breaks the streak
  /// Returns current streak (days) and best streak (days)
  Future<Map<String, int>> getStrictStreak() async {
    // Get all entries with prayed or prayedLate status
    final allEntries = await (_db.select(_db.prayerEntries)
          ..where((p) =>
              (p.status.equals(PrayerStatus.prayed.name)) |
              (p.status.equals(PrayerStatus.prayedLate.name)))
          ..orderBy([(p) => OrderingTerm.desc(p.localDate)]))
        .get();

    if (allEntries.isEmpty) {
      return {'current': 0, 'best': 0};
    }

    // Group by localDate and count distinct prayers per day
    final Map<String, Set<PrayerType>> prayersByDate = {};
    for (final entry in allEntries) {
      prayersByDate.putIfAbsent(entry.localDate, () => <PrayerType>{}).add(entry.prayer);
    }

    // Filter to only days with all 5 prayers
    final completeDays = prayersByDate.entries
        .where((e) => e.value.length == 5)
        .map((e) => e.key)
        .toList()
      ..sort((a, b) => b.compareTo(a));

    if (completeDays.isEmpty) {
      return {'current': 0, 'best': 0};
    }

    // Calculate current streak (consecutive days from today)
    int currentStreak = 0;
    final today = currentLocalDate();
    
    // Check if today is complete
    if (completeDays.contains(today)) {
      currentStreak = 1;
      // Parse today's date
      final todayParts = today.split('-');
      var currentDate = DateTime(
        int.parse(todayParts[0]),
        int.parse(todayParts[1]),
        int.parse(todayParts[2]),
      );

      // Count consecutive days backwards
      for (final dateStr in completeDays) {
        if (dateStr == today) continue; // Already counted
        
        final dateParts = dateStr.split('-');
        final entryDate = DateTime(
          int.parse(dateParts[0]),
          int.parse(dateParts[1]),
          int.parse(dateParts[2]),
        );

        final daysDiff = currentDate.difference(entryDate).inDays;
        if (daysDiff == 1) {
          currentStreak++;
          currentDate = entryDate;
        } else if (daysDiff > 1) {
          // Gap found, streak broken
          break;
        }
      }
    }

    // Calculate best streak (longest consecutive sequence)
    int bestStreak = 0;
    int tempStreak = 0;
    String? prevDate;

    for (final dateStr in completeDays) {
      final dateParts = dateStr.split('-');
      final entryDate = DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
      );

      if (prevDate == null) {
        tempStreak = 1;
        prevDate = dateStr;
      } else {
        final prevParts = prevDate.split('-');
        final prevDateTime = DateTime(
          int.parse(prevParts[0]),
          int.parse(prevParts[1]),
          int.parse(prevParts[2]),
        );

        final daysDiff = prevDateTime.difference(entryDate).inDays;
        if (daysDiff == 1) {
          tempStreak++;
        } else {
          // Gap found, reset streak
          if (tempStreak > bestStreak) {
            bestStreak = tempStreak;
          }
          tempStreak = 1;
        }
        prevDate = dateStr;
      }
    }

    // Check final streak
    if (tempStreak > bestStreak) {
      bestStreak = tempStreak;
    }

    return {
      'current': currentStreak,
      'best': bestStreak,
    };
  }

  /// Get monthly prayer status for calendar display
  /// Returns a map of localDate -> completion status
  /// Status: 'complete' (all 5), 'partial' (1-4), 'none' (0)
  Future<Map<String, String>> getMonthPrayerStatus(int year, int month) async {
    // Calculate date range for the month
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);
    
    final firstDateStr = _formatLocalDate(firstDay);
    final lastDateStr = _formatLocalDate(lastDay);

    // Get all entries for the month
    final entries = await (_db.select(_db.prayerEntries)
          ..where((p) =>
              (p.localDate.isBiggerOrEqualValue(firstDateStr)) &
              (p.localDate.isSmallerOrEqualValue(lastDateStr))))
        .get();

    // Group by localDate and count distinct prayers per day
    final Map<String, Set<PrayerType>> prayersByDate = {};
    for (final entry in entries) {
      prayersByDate.putIfAbsent(entry.localDate, () => <PrayerType>{}).add(entry.prayer);
    }

    // Build result map
    final result = <String, String>{};
    
    // Iterate through all days in the month
    var currentDate = firstDay;
    while (currentDate.month == month) {
      final dateStr = _formatLocalDate(currentDate);
      final prayers = prayersByDate[dateStr] ?? <PrayerType>{};
      
      if (prayers.length == 5) {
        result[dateStr] = 'complete';
      } else if (prayers.isNotEmpty) {
        result[dateStr] = 'partial';
      } else {
        result[dateStr] = 'none';
      }
      
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return result;
  }

  /// Helper to format DateTime as ISO YYYY-MM-DD string
  String _formatLocalDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}

