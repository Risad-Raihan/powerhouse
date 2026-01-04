import 'package:drift/drift.dart';
import '../../core/database/app_database.dart';
import '../../core/database/converters/enum_converters.dart';
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

  /// Watch the current reading item (reactive)
  /// Prefers most recently statusUpdatedAtUtc item with status = currentlyReading
  /// Falls back to most recent addedAtUtc non-archived item if none exist
  Stream<ReadingItem?> watchCurrentReading() {
      // Watch all non-archived items and select the appropriate one
      final allItemsQuery = _db.select(_db.readingItems)
        ..where((r) => r.isArchived.equals(false));
      
      return allItemsQuery.watch().map((items) {
        if (items.isEmpty) return null;
        
        // First try to find currentlyReading items
        final currentlyReading = items
            .where((item) => item.status.name == 'currentlyReading')
            .toList();
      
      if (currentlyReading.isNotEmpty) {
        // Sort by statusUpdatedAtUtc DESC and return first
        currentlyReading.sort((a, b) => 
          b.statusUpdatedAtUtc.compareTo(a.statusUpdatedAtUtc));
        return currentlyReading.first;
      }
      
      // Fallback to most recent by addedAtUtc
      items.sort((a, b) => b.addedAtUtc.compareTo(a.addedAtUtc));
      return items.first;
    });
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

  /// Watch reading items filtered by status (reactive)
  Stream<List<ReadingItem>> watchItemsByStatus(ReadingStatus status) {
    final query = _db.select(_db.readingItems)
      ..where((r) => r.isArchived.equals(false))
      ..where((r) => r.status.equals(status.name))
      ..orderBy([(r) => OrderingTerm.desc(r.statusUpdatedAtUtc)]);
    return query.watch();
  }

  /// Insert a new reading item
  /// Returns the ID of the inserted item
  Future<int> insertReadingItem({
    required String title,
    String? author,
    required ReadingType type,
    int? totalUnits,
    String? coverImagePath,
    required ReadingStatus status,
    required DateTime nowUtc,
  }) async {
    final companion = ReadingItemsCompanion.insert(
      title: title,
      author: Value(author),
      type: type,
      totalUnits: Value(totalUnits),
      coverImagePath: Value(coverImagePath),
      addedAtUtc: nowUtc,
      status: Value(status),
      statusUpdatedAtUtc: nowUtc,
      completedAtUtc: status == ReadingStatus.done ? Value(nowUtc) : const Value.absent(),
    );
    return await _db.into(_db.readingItems).insert(companion);
  }

  /// Update reading status with invariants:
  /// - statusUpdatedAtUtc is always updated on status change
  /// - completedAtUtc is set only when status becomes done AND it's currently null
  /// - completedAtUtc is never modified after it's set
  Future<void> updateReadingStatus({
    required int id,
    required ReadingStatus newStatus,
    required DateTime nowUtc,
  }) async {
    // Get current item to check completedAtUtc
    final item = await (_db.select(_db.readingItems)
          ..where((r) => r.id.equals(id)))
        .getSingleOrNull();
    
    if (item == null) {
      throw ArgumentError('Reading item with id $id not found');
    }

    final companion = ReadingItemsCompanion(
      status: Value(newStatus),
      statusUpdatedAtUtc: Value(nowUtc),
      completedAtUtc: newStatus == ReadingStatus.done && item.completedAtUtc == null
          ? Value(nowUtc)
          : const Value.absent(), // Don't modify if already set or not becoming done
    );

    await (_db.update(_db.readingItems)..where((r) => r.id.equals(id))).write(companion);
  }

  /// Check if a book with the same title and author already exists (non-archived)
  /// Returns true if duplicate exists
  Future<bool> checkDuplicateBook({
    required String title,
    String? author,
  }) async {
    final query = _db.select(_db.readingItems)
      ..where((r) => r.isArchived.equals(false))
      ..where((r) => r.title.equals(title));
    
    if (author != null) {
      query.where((r) => r.author.equals(author));
    } else {
      query.where((r) => r.author.isNull());
    }
    
    final existing = await query.getSingleOrNull();
    return existing != null;
  }
}

