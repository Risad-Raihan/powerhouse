import 'package:drift/drift.dart';

/// XP events table
/// Event-based gamification system
/// Levels are derived via queries, not stored
class XpEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Source of XP (prayer, reading, capture)
  TextColumn get source => text()();
  
  // ID of the source item (nullable if source doesn't require it)
  IntColumn get sourceId => integer().nullable()();
  
  // XP amount awarded
  IntColumn get xp => integer()();
  
  // Reason for XP award (optional)
  TextColumn get reason => text().nullable()();
  
  // UTC timestamp when XP was awarded
  DateTimeColumn get createdAtUtc => dateTime()();
  
  // Local date in ISO YYYY-MM-DD format (for day-based queries)
  TextColumn get localDate => text()();
}

