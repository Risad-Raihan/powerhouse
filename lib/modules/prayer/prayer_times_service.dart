import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/database/converters/enum_converters.dart';

/// Prayer time model
class PrayerTime {
  final PrayerType prayer;
  final DateTime startTime;
  final DateTime endTime;

  PrayerTime({
    required this.prayer,
    required this.startTime,
    required this.endTime,
  });
}

/// Service for fetching prayer times from AlAdhan API
/// Configuration locked to Dhaka, Bangladesh with Karachi method and Hanafi madhab
class PrayerTimesService {
  static const String _baseUrl = 'https://api.aladhan.com/v1';
  static const String _city = 'Dhaka';
  static const String _country = 'Bangladesh';
  static const int _method = 1; // Karachi (University of Islamic Sciences)
  static const int _school = 1; // Hanafi
  static const String _timezone = 'Asia/Dhaka';

  /// Fetch prayer times for a specific date
  /// Returns a list of PrayerTime objects for all 5 prayers
  /// Throws exception on API failure
  Future<List<PrayerTime>> fetchPrayerTimes(DateTime date) async {
    // Format date as DD-MM-YYYY for API
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    final dateStr = '$day-$month-$year';

    final uri = Uri.parse('$_baseUrl/timingsByCity/$dateStr')
        .replace(queryParameters: {
      'city': _city,
      'country': _country,
      'method': _method.toString(),
      'school': _school.toString(),
      'timezone': _timezone,
    });

    try {
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to fetch prayer times: ${response.statusCode}');
      }

      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final data = jsonData['data'] as Map<String, dynamic>;
      final timings = data['timings'] as Map<String, dynamic>;

      // Parse prayer times
      final prayerTimes = <PrayerTime>[];

      // Helper to parse time string (HH:mm format) to DateTime for the given date
      DateTime parseTime(String timeStr, DateTime date) {
        final parts = timeStr.split(':');
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        return DateTime(date.year, date.month, date.day, hour, minute);
      }

      // Get all prayer times
      final fajrStr = timings['Fajr'] as String;
      final sunriseStr = timings['Sunrise'] as String;
      final dhuhrStr = timings['Dhuhr'] as String;
      final asrStr = timings['Asr'] as String;
      final maghribStr = timings['Maghrib'] as String;
      final ishaStr = timings['Isha'] as String;

      // Parse times (remove any timezone suffix if present)
      final fajr = parseTime(fajrStr.split(' ')[0], date);
      final sunrise = parseTime(sunriseStr.split(' ')[0], date);
      final dhuhr = parseTime(dhuhrStr.split(' ')[0], date);
      final asr = parseTime(asrStr.split(' ')[0], date);
      final maghrib = parseTime(maghribStr.split(' ')[0], date);
      final isha = parseTime(ishaStr.split(' ')[0], date);

      // Get next day's Fajr for Isha end time
      // Fetch both today and tomorrow in parallel for efficiency
      final nextDay = date.add(const Duration(days: 1));
      final nextDayFajrStr = await _getNextDayFajr(nextDay);
      final nextDayFajrTime = parseTime(nextDayFajrStr.split(' ')[0], nextDay);

      // Create PrayerTime objects with start and end times
      prayerTimes.add(PrayerTime(
        prayer: PrayerType.fajr,
        startTime: fajr,
        endTime: sunrise,
      ));

      prayerTimes.add(PrayerTime(
        prayer: PrayerType.dhuhr,
        startTime: dhuhr,
        endTime: asr,
      ));

      prayerTimes.add(PrayerTime(
        prayer: PrayerType.asr,
        startTime: asr,
        endTime: maghrib,
      ));

      prayerTimes.add(PrayerTime(
        prayer: PrayerType.maghrib,
        startTime: maghrib,
        endTime: isha,
      ));

      prayerTimes.add(PrayerTime(
        prayer: PrayerType.isha,
        startTime: isha,
        endTime: nextDayFajrTime,
      ));

      return prayerTimes;
    } catch (e) {
      throw Exception('Failed to fetch prayer times: $e');
    }
  }

  /// Helper to get next day's Fajr time
  Future<String> _getNextDayFajr(DateTime date) async {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    final dateStr = '$day-$month-$year';

    final uri = Uri.parse('$_baseUrl/timingsByCity/$dateStr')
        .replace(queryParameters: {
      'city': _city,
      'country': _country,
      'method': _method.toString(),
      'school': _school.toString(),
      'timezone': _timezone,
    });

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch next day Fajr: ${response.statusCode}');
    }

    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    final data = jsonData['data'] as Map<String, dynamic>;
    final timings = data['timings'] as Map<String, dynamic>;
    return timings['Fajr'] as String;
  }
}

