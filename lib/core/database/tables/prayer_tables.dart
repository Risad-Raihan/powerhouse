import 'package:drift/drift.dart';
import '../converters/enum_converters.dart';

/// Prayer entries table
/// Stores manual prayer logging data
/// UNIQUE constraint on (localDate, prayer) ensures one entry per prayer per day
class PrayerEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Prayer type (Fajr, Dhuhr, Asr, Maghrib, Isha)
  TextColumn get prayer => text().map(prayerTypeConverter)();
  
  // Status (Pending, Prayed, PrayedLate, Missed)
  TextColumn get status => text().map(prayerStatusConverter)();
  
  // UTC timestamp when prayer was logged
  DateTimeColumn get loggedAtUtc => dateTime()();
  
  // Local date in ISO YYYY-MM-DD format (for day-based queries)
  TextColumn get localDate => text()();
  
  // Timezone used for localDate calculation (default: Asia/Dhaka)
  TextColumn get timezone => text().withDefault(const Constant('Asia/Dhaka'))();
  
  // Optional note
  TextColumn get note => text().nullable()();
  
  // XP awarded for this prayer entry
  IntColumn get xpAwarded => integer().withDefault(const Constant(0))();
  
  @override
  List<Set<Column>> get uniqueKeys => [
    {localDate, prayer},
  ];
}

