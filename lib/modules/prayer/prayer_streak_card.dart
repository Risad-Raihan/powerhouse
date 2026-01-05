import 'package:flutter/material.dart';
import '../../core/theme/powerhouse_colors.dart';
import '../../core/theme/theme_extensions.dart';

/// Prayer streak card - displays strict streak (all 5 prayers required)
class PrayerStreakCard extends StatelessWidget {
  final int currentStreak;
  final int bestStreak;

  const PrayerStreakCard({
    super.key,
    required this.currentStreak,
    required this.bestStreak,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<PowerHouseCardTokens>();
    final textTheme = Theme.of(context).textTheme;

    if (tokens == null) {
      throw StateError('PowerHouseCardTokens not found in theme');
    }

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
              PowerHouseColors.prayerGreenLight.withValues(alpha: 0.4),
              PowerHouseColors.prayerGreenMedium.withValues(alpha: 0.2),
            ],
          ),
        ),
        child: Padding(
          padding: tokens.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Prayer Streak',
                style: textTheme.titleMedium?.copyWith(
                  color: PowerHouseColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStreakItem(
                      context: context,
                      label: 'Current',
                      value: currentStreak,
                      textTheme: textTheme,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 60,
                    color: PowerHouseColors.divider,
                  ),
                  Expanded(
                    child: _buildStreakItem(
                      context: context,
                      label: 'Best',
                      value: bestStreak,
                      textTheme: textTheme,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'All 5 prayers must be completed each day',
                style: textTheme.bodySmall?.copyWith(
                  color: PowerHouseColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStreakItem({
    required BuildContext context,
    required String label,
    required int value,
    required TextTheme textTheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: PowerHouseColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$value',
          style: textTheme.headlineSmall?.copyWith(
            color: PowerHouseColors.prayerGreenDeep,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value == 1 ? 'day' : 'days',
          style: textTheme.bodySmall?.copyWith(
            color: PowerHouseColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

