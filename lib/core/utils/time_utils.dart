import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

/// Timezone utilities for PowerHouse.
/// All DateTime values are stored in UTC.
/// Day-based logic uses localDate (ISO YYYY-MM-DD format).
/// Default timezone: Asia/Dhaka

bool _timezonesInitialized = false;

/// Initialize timezone data (lazy, called once)
void _ensureTimezonesInitialized() {
  if (!_timezonesInitialized) {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('UTC'));
    _timezonesInitialized = true;
  }
}

/// Get current UTC DateTime
DateTime nowUtc() {
  return DateTime.now().toUtc();
}

/// Get current local date as ISO YYYY-MM-DD string
/// Uses the specified timezone (default: Asia/Dhaka)
String currentLocalDate({String timezone = 'Asia/Dhaka'}) {
  _ensureTimezonesInitialized();
  final tzLocation = tz.getLocation(timezone);
  final now = tz.TZDateTime.now(tzLocation);
  return _formatLocalDate(now);
}

/// Convert UTC DateTime to local date string (ISO YYYY-MM-DD)
/// Uses the specified timezone (default: Asia/Dhaka)
String utcToLocalDate(DateTime utc, String timezone) {
  _ensureTimezonesInitialized();
  final tzLocation = tz.getLocation(timezone);
  final localTime = tz.TZDateTime.from(utc, tzLocation);
  return _formatLocalDate(localTime);
}

/// Format a TZDateTime as ISO YYYY-MM-DD string
String _formatLocalDate(tz.TZDateTime dateTime) {
  final year = dateTime.year.toString().padLeft(4, '0');
  final month = dateTime.month.toString().padLeft(2, '0');
  final day = dateTime.day.toString().padLeft(2, '0');
  return '$year-$month-$day';
}

/// Convert UTC DateTime to local midnight DateTime in specified timezone
/// Returns a DateTime at midnight (00:00:00) in the local timezone
/// Uses the specified timezone (default: Asia/Dhaka)
DateTime utcToLocalMidnight(DateTime utc, {String timezone = 'Asia/Dhaka'}) {
  _ensureTimezonesInitialized();
  final tzLocation = tz.getLocation(timezone);
  final localTime = tz.TZDateTime.from(utc, tzLocation);
  // Return midnight of the local date
  return tz.TZDateTime(
    tzLocation,
    localTime.year,
    localTime.month,
    localTime.day,
  );
}

