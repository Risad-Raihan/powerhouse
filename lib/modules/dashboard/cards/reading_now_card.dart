import 'package:flutter/material.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/theme/theme_extensions.dart';
import 'dashboard_card_animations.dart';

/// Reading now card - shows current reading title and progress placeholder
class ReadingNowCard extends StatelessWidget {
  final ReadingItem? currentReading;
  final List<ReadingSession> todayReadingSessions;

  const ReadingNowCard({
    super.key,
    required this.currentReading,
    required this.todayReadingSessions,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<PowerHouseCardTokens>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
                'Reading Now',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: AnimatedSwitcher(
                  duration: kUiAnimDuration,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.1),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: kUiCurve,
                          ),
                        ),
                        child: child,
                      ),
                    );
                  },
                  child: currentReading == null
                      ? Center(
                          key: const ValueKey('empty'),
                          child: Text(
                            'No active reading',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        )
                      : _buildReadingContent(
                          key: ValueKey('reading-${currentReading!.id}'),
                          reading: currentReading!,
                          todayReadingSessions: todayReadingSessions,
                          colorScheme: colorScheme,
                          textTheme: textTheme,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReadingContent({
    required Key key,
    required ReadingItem reading,
    required List<ReadingSession> todayReadingSessions,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    // Compute progress if possible
    double? progress;
    if (reading.totalUnits != null && reading.totalUnits! > 0) {
      final sessionsForThisReading = todayReadingSessions
          .where((s) => s.readingItemId == reading.id)
          .where((s) => s.progressUnits != null)
          .toList();
      final readUnitsToday = sessionsForThisReading
          .map((s) => s.progressUnits!)
          .fold<int>(0, (sum, units) => sum + units);
      if (readUnitsToday > 0) {
        progress = (readUnitsToday / reading.totalUnits!).clamp(0.0, 1.0);
      }
    }

    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          reading.title,
          style: textTheme.titleSmall?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (reading.author != null) ...[
          const SizedBox(height: 4),
          Text(
            reading.author!,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
        const SizedBox(height: 16),
        _buildProgressBar(
          progress: progress,
          colorScheme: colorScheme,
        ),
      ],
    );
  }

  Widget _buildProgressBar({
    required double? progress,
    required ColorScheme colorScheme,
  }) {
    if (progress == null) {
      return LinearProgressIndicator(
        value: null,
        backgroundColor: colorScheme.surfaceContainerHighest,
        valueColor: AlwaysStoppedAnimation<Color>(
          colorScheme.primary,
        ),
      );
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(end: progress),
      duration: kProgressAnimDuration,
      curve: kProgressCurve,
      builder: (context, animatedProgress, child) {
        return LinearProgressIndicator(
          value: animatedProgress,
          backgroundColor: colorScheme.surfaceContainerHighest,
          valueColor: AlwaysStoppedAnimation<Color>(
            colorScheme.primary,
          ),
        );
      },
    );
  }
}

