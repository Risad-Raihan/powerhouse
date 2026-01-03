import 'package:drift/drift.dart';
import '../converters/enum_converters.dart';

/// Capture items table
/// Zero-friction capture of notes, thoughts, ideas, quotes
/// Optional linking to other modules via linkedModule and linkedId
class CaptureItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Type of capture (Note, Thought, Idea, Quote)
  TextColumn get type => text().map(captureTypeConverter)();
  
  // Content of the capture
  TextColumn get content => text()();
  
  // UTC timestamp when capture was created
  DateTimeColumn get createdAtUtc => dateTime()();
  
  // Local date in ISO YYYY-MM-DD format (for day-based queries)
  TextColumn get localDate => text()();
  
  // Optional link to another module (e.g., "reading", "prayer")
  TextColumn get linkedModule => text().nullable()();
  
  // Optional ID of the linked item in the linked module
  IntColumn get linkedId => integer().nullable()();
}

