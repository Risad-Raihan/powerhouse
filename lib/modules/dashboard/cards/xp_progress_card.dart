import 'package:flutter/material.dart';
import '../../../../core/theme/theme_extensions.dart';

/// XP progress card - shows level placeholder and XP progress bars
class XpProgressCard extends StatelessWidget {
  final int todayXp;
  final int totalXp;

  const XpProgressCard({
    super.key,
    required this.todayXp,
    required this.totalXp,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<PowerHouseCardTokens>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final accentTokens = Theme.of(context).extension<PowerHouseAccentTokens>();

    if (tokens == null) {
      throw StateError('PowerHouseCardTokens not found in theme');
    }

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
                'Progress',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Level 1',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildXpBar(
                      context: context,
                      label: 'Today',
                      value: todayXp,
                      maxValue: 100,
                      color: accentTokens?.primaryAccent ?? colorScheme.primary,
                      textTheme: textTheme,
                      colorScheme: colorScheme,
                    ),
                    const SizedBox(height: 16),
                    _buildXpBar(
                      context: context,
                      label: 'Total',
                      value: totalXp,
                      maxValue: 1000,
                      color: accentTokens?.secondaryAccent ?? colorScheme.secondary,
                      textTheme: textTheme,
                      colorScheme: colorScheme,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildXpBar({
    required BuildContext context,
    required String label,
    required int value,
    required int maxValue,
    required Color color,
    required TextTheme textTheme,
    required ColorScheme colorScheme,
  }) {
    final progress = (value / maxValue).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            Text(
              '$value / $maxValue',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}

