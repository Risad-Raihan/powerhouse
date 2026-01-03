import 'package:flutter/material.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/theme/theme_extensions.dart';

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
                child: currentReading == null
                    ? Center(
                        child: Text(
                          'No active reading',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      )
                    : Builder(
                        builder: (context) {
                          final reading = currentReading!;
                          return Column(
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
                              LinearProgressIndicator(
                                value: null,
                                backgroundColor: colorScheme.surfaceContainerHighest,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  colorScheme.primary,
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

