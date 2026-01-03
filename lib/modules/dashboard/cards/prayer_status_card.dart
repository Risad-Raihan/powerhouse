import 'package:flutter/material.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/converters/enum_converters.dart';
import '../../../../core/theme/theme_extensions.dart';

/// Prayer status card - shows 5 prayer statuses (Fajr, Dhuhr, Asr, Maghrib, Isha)
class PrayerStatusCard extends StatelessWidget {
  final List<PrayerEntry> todaysPrayers;

  const PrayerStatusCard({
    super.key,
    required this.todaysPrayers,
  });

  PrayerEntry? _findPrayer(List<PrayerEntry> prayers, PrayerType type) {
    try {
      return prayers.firstWhere((p) => p.prayer == type);
    } catch (_) {
      return null;
    }
  }

  IconData _getStatusIcon(PrayerStatus status) {
    switch (status) {
      case PrayerStatus.prayed:
        return Icons.check_circle;
      case PrayerStatus.prayedLate:
        return Icons.check_circle_outline;
      case PrayerStatus.missed:
        return Icons.cancel;
      case PrayerStatus.pending:
        return Icons.radio_button_unchecked;
    }
  }

  Color _getStatusColor(PrayerStatus status, ColorScheme colorScheme) {
    switch (status) {
      case PrayerStatus.prayed:
        return colorScheme.primary;
      case PrayerStatus.prayedLate:
        return colorScheme.secondary;
      case PrayerStatus.missed:
        return colorScheme.error;
      case PrayerStatus.pending:
        return colorScheme.onSurface.withValues(alpha: 0.3);
    }
  }

  String _getPrayerName(PrayerType type) {
    switch (type) {
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

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<PowerHouseCardTokens>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (tokens == null) {
      throw StateError('PowerHouseCardTokens not found in theme');
    }

    final prayers = [
      PrayerType.fajr,
      PrayerType.dhuhr,
      PrayerType.asr,
      PrayerType.maghrib,
      PrayerType.isha,
    ];

    return Card(
      elevation: tokens.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.radius),
      ),
      child: InkWell(
        onTap: () {
          // Placeholder for tap action
        },
        borderRadius: BorderRadius.circular(tokens.radius),
        child: Padding(
          padding: tokens.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Prayers',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: prayers.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8), // ignore: unnecessary_underscores
                  itemBuilder: (_, index) {
                    final prayerType = prayers[index];
                    final entry = _findPrayer(todaysPrayers, prayerType);
                    final status = entry?.status ?? PrayerStatus.pending;
                    final icon = _getStatusIcon(status);
                    final color = _getStatusColor(status, colorScheme);
                    final name = _getPrayerName(prayerType);

                    return Row(
                      children: [
                        Icon(
                          icon,
                          color: color,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          name,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

