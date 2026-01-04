import 'package:drift/drift.dart';
import '../converters/enum_converters.dart';

/// Reading items table
/// Stores books, articles, PDFs that the user is reading or has read
class ReadingItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Title of the reading item
  TextColumn get title => text()();
  
  // Author (nullable)
  TextColumn get author => text().nullable()();
  
  // Type (Book, Article, PDF)
  TextColumn get type => text().map(readingTypeConverter)();
  
  // Total units (pages, chapters, etc.) - nullable
  IntColumn get totalUnits => integer().nullable()();
  
  // Path to cover image (nullable)
  TextColumn get coverImagePath => text().nullable()();
  
  // UTC timestamp when item was added
  DateTimeColumn get addedAtUtc => dateTime()();
  
  // Whether the item is archived
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  
  // Reading status (wantToRead, currentlyReading, done)
  TextColumn get status => text().map(readingStatusConverter).withDefault(const Constant('wantToRead'))();
  
  // UTC timestamp when status was last updated
  DateTimeColumn get statusUpdatedAtUtc => dateTime()();
  
  // UTC timestamp when item was marked as done (nullable, set only when status becomes done)
  DateTimeColumn get completedAtUtc => dateTime().nullable()();
}

/// Reading sessions table
/// Tracks individual reading sessions for analytics and streaks
class ReadingSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Foreign key to reading_items
  IntColumn get readingItemId => integer()();
  
  // Duration of reading session in minutes
  IntColumn get durationMinutes => integer()();
  
  // Progress units (pages read, chapters completed, etc.) - nullable
  IntColumn get progressUnits => integer().nullable()();
  
  // UTC timestamp when session was created
  DateTimeColumn get createdAtUtc => dateTime()();
  
  // Local date in ISO YYYY-MM-DD format (for day-based queries)
  TextColumn get localDate => text()();
}

