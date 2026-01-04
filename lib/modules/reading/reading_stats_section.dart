import 'package:flutter/material.dart';
import '../../core/theme/theme_extensions.dart';
import '../../core/theme/powerhouse_colors.dart';
import 'reading_page.dart';

/// Reading stats section - displays week/month bar charts
class ReadingStatsSection extends StatelessWidget {
  final ReadingPeriodStats weekStats;
  final ReadingPeriodStats monthStats;
  final ReadingPeriodStats yearStats; // Not used but kept for compatibility

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
            // Tablet-friendly: 2 columns on wide screens, 1 on narrow
            final isWide = constraints.maxWidth >= 600;
            final crossAxisCount = isWide ? 2 : 1;

            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: tokens.paddingSmall.horizontal / 2,
              mainAxisSpacing: tokens.paddingSmall.horizontal / 2,
              childAspectRatio: isWide ? 1.8 : 1.5,
              children: [
                _buildBarChartCard(
                  context,
                  label: 'This Week',
                  stats: weekStats,
                  tokens: tokens,
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                ),
                _buildBarChartCard(
                  context,
                  label: 'This Month',
                  stats: monthStats,
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

  Widget _buildBarChartCard(
    BuildContext context, {
    required String label,
    required ReadingPeriodStats stats,
    required PowerHouseCardTokens tokens,
    required TextTheme textTheme,
    required ColorScheme colorScheme,
  }) {
    final maxValue = (stats.readingCount + stats.doneCount).clamp(1, double.infinity).toDouble();
    final readingHeight = maxValue > 0 ? (stats.readingCount / maxValue) : 0.0;
    final doneHeight = maxValue > 0 ? (stats.doneCount / maxValue) : 0.0;

    return Card(
      elevation: tokens.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.radius),
      ),
      child: Padding(
        padding: tokens.paddingSmall,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            // Bar chart
            SizedBox(
              height: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Reading bar
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colorScheme.surfaceContainerHighest,
                          ),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                height: 80 * readingHeight.clamp(0.0, 1.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      PowerHouseColors.accentTeal,
                                      PowerHouseColors.accentTeal.withValues(alpha: 0.8),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${stats.readingCount}',
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: PowerHouseColors.accentTeal,
                          ),
                        ),
                        Text(
                          'Reading',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Done bar
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colorScheme.surfaceContainerHighest,
                          ),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                height: 80 * doneHeight.clamp(0.0, 1.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      PowerHouseColors.accentAmber,
                                      PowerHouseColors.accentAmber.withValues(alpha: 0.8),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${stats.doneCount}',
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: PowerHouseColors.accentAmber,
                          ),
                        ),
                        Text(
                          'Done',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Sessions info
            Text(
              '${stats.sessionsCount} sessions • ${stats.totalMinutes} min',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

