import 'package:flutter/material.dart';
import '../../core/theme/theme_extensions.dart';
import 'reading_page.dart';

/// Reading stats section - displays week/month/year statistics
class ReadingStatsSection extends StatelessWidget {
  final ReadingPeriodStats weekStats;
  final ReadingPeriodStats monthStats;
  final ReadingPeriodStats yearStats;

  const ReadingStatsSection({
    super.key,
    required this.weekStats,
    required this.monthStats,
    required this.yearStats,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<PowerHouseCardTokens>();
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    if (tokens == null) {
      throw StateError('PowerHouseCardTokens not found in theme');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reading Stats',
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            // Tablet-friendly: 3 columns on wide screens, fewer on narrow
            final isWide = constraints.maxWidth >= 800;
            final crossAxisCount = isWide ? 3 : (constraints.maxWidth >= 600 ? 2 : 1);

            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: tokens.paddingSmall.horizontal / 2,
              mainAxisSpacing: tokens.paddingSmall.horizontal / 2,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard(
                  context,
                  label: 'This Week',
                  stats: weekStats,
                  tokens: tokens,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                ),
                _buildStatCard(
                  context,
                  label: 'This Month',
                  stats: monthStats,
                  tokens: tokens,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                ),
                _buildStatCard(
                  context,
                  label: 'This Year',
                  stats: yearStats,
                  tokens: tokens,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String label,
    required ReadingPeriodStats stats,
    required PowerHouseCardTokens tokens,
    required TextTheme textTheme,
    required ColorScheme colorScheme,
  }) {
    return Card(
      elevation: tokens.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.radius),
      ),
      child: Padding(
        padding: tokens.paddingSmall,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${stats.sessionsCount}',
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${stats.totalMinutes} min',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: stats.progressValue,
              backgroundColor: colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                colorScheme.primary.withValues(alpha: 0.6),
              ),
              minHeight: 4,
            ),
          ],
        ),
      ),
    );
  }
}

