import 'package:flutter/material.dart';
import '../../core/database/converters/enum_converters.dart';
import '../../core/theme/powerhouse_colors.dart';
import '../../core/theme/theme_extensions.dart';
import 'prayer_times_service.dart';

/// Prayer times card - displays all 5 prayer times with start/end times
/// Highlights the current prayer window
class PrayerTimesCard extends StatelessWidget {
  final List<PrayerTime> prayerTimes;
  final DateTime now;

  const PrayerTimesCard({
    super.key,
    required this.prayerTimes,
    required this.now,
  });

  String _getPrayerName(PrayerType prayer) {
    switch (prayer) {
      case PrayerType.fajr:
        return 'Fajr';
      case PrayerType.dhuhr:
        return 'Dhuhr';
      case PrayerType.asr:
        return 'Asr';
      case PrayerType.maghrib:
        return 'Maghrib';
      case PrayerType.isha:
        return 'Isha';
    }
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  PrayerTime? _getCurrentPrayer() {
    for (final prayerTime in prayerTimes) {
      if (now.isAfter(prayerTime.startTime) &&
          now.isBefore(prayerTime.endTime)) {
        return prayerTime;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<PowerHouseCardTokens>();
    final textTheme = Theme.of(context).textTheme;

    if (tokens == null) {
      throw StateError('PowerHouseCardTokens not found in theme');
    }

    final currentPrayer = _getCurrentPrayer();

    return Card(
      elevation: tokens.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.radius),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(tokens.radius),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              PowerHouseColors.prayerGreenMuted,
              PowerHouseColors.prayerGreenLight.withValues(alpha: 0.3),
            ],
          ),
        ),
        child: Padding(
          padding: tokens.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Prayer Times",
                style: textTheme.titleMedium?.copyWith(
                  color: PowerHouseColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              ...prayerTimes.map((prayerTime) {
                final isCurrent = currentPrayer?.prayer == prayerTime.prayer;
                return _buildPrayerTimeRow(
                  context: context,
                  prayerTime: prayerTime,
                  isCurrent: isCurrent,
                  textTheme: textTheme,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrayerTimeRow({
    required BuildContext context,
    required PrayerTime prayerTime,
    required bool isCurrent,
    required TextTheme textTheme,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrent
            ? PowerHouseColors.prayerGreenMedium.withValues(alpha: 0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isCurrent
            ? Border.all(
                color: PowerHouseColors.prayerGreenDeep.withValues(alpha: 0.3),
                width: 1.5,
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              _getPrayerName(prayerTime.prayer),
              style: textTheme.bodyLarge?.copyWith(
                color: PowerHouseColors.textPrimary,
                fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatTime(prayerTime.startTime),
                style: textTheme.bodyMedium?.copyWith(
                  color: PowerHouseColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'until ${_formatTime(prayerTime.endTime)}',
                style: textTheme.bodySmall?.copyWith(
                  color: PowerHouseColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

