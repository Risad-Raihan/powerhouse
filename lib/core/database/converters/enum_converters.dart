import 'package:drift/drift.dart';

/// Enums for v1 PowerHouse modules

enum PrayerType {
  fajr,
  dhuhr,
  asr,
  maghrib,
  isha,
}

enum PrayerStatus {
  pending,
  prayed,
  prayedLate,
  missed,
}

enum ReadingType {
  book,
  article,
  pdf,
}

enum CaptureType {
  note,
  thought,
  idea,
  quote,
}

enum ReadingStatus {
  wantToRead,
  currentlyReading,
  done,
}

/// Reusable Drift TypeConverter that stores enums as TEXT using enum.name
class EnumConverter<T extends Enum> extends TypeConverter<T, String> {
  final List<T> values;

  EnumConverter(this.values);

  @override
  T fromSql(String fromDb) {
    return values.firstWhere(
      (e) => e.name == fromDb,
      orElse: () => throw ArgumentError('Unknown enum value: $fromDb'),
    );
  }

  @override
  String toSql(T value) {
    return value.name;
  }
}

/// Specific converters for each enum type
final prayerTypeConverter = EnumConverter<PrayerType>(PrayerType.values);
final prayerStatusConverter = EnumConverter<PrayerStatus>(PrayerStatus.values);
final readingTypeConverter = EnumConverter<ReadingType>(ReadingType.values);
final captureTypeConverter = EnumConverter<CaptureType>(CaptureType.values);
final readingStatusConverter = EnumConverter<ReadingStatus>(ReadingStatus.values);

