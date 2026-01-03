import 'package:drift/drift.dart';

/// Insight entries table
/// Stores rule-based insights (v1) and LLM-generated insights (v2)
/// Insights can expire or be permanent (expiresAtUtc = null)
class InsightEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Type of insight (prayer, reading, habit)
  TextColumn get type => text()();
  
  // Insight message
  TextColumn get message => text()();
  
  // UTC timestamp when insight was generated
  DateTimeColumn get generatedAtUtc => dateTime()();
  
  // UTC timestamp when insight expires (null = permanent)
  DateTimeColumn get expiresAtUtc => dateTime().nullable()();
}

