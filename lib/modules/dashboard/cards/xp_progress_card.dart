import 'package:flutter/material.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../gamification/gamification_page.dart';
import 'dashboard_card_animations.dart';

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
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const GamificationPage()),
          );
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
              _buildLevelDisplay(
                level: (totalXp ~/ 1000) + 1,
                colorScheme: colorScheme,
                textTheme: textTheme,
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

  Widget _buildLevelDisplay({
    required int level,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return AnimatedSwitcher(
      duration: kUiAnimDuration,
      transitionBuilder: dashboardCardTransitionBuilder,
      child: AnimatedContainer(
        key: ValueKey(level),
        duration: kUiAnimDuration,
        curve: kUiCurve,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Text(
          'Level $level',
          style: textTheme.headlineSmall?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
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
            AnimatedSwitcher(
              duration: kUiAnimDuration,
              transitionBuilder: dashboardCardTransitionBuilder,
              child: Text(
                '$value / $maxValue',
                key: ValueKey(value),
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(end: progress),
            duration: kProgressAnimDuration,
            curve: kProgressCurve,
            builder: (context, animatedProgress, child) {
              return _buildGradientProgressBar(
                progress: animatedProgress,
                color: color,
                colorScheme: colorScheme,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGradientProgressBar({
    required double progress,
    required Color color,
    required ColorScheme colorScheme,
  }) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color,
                color.withValues(alpha: 0.8),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

