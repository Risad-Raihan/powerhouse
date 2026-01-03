import 'package:flutter/material.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/converters/enum_converters.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../capture/capture_page.dart';

/// Quick capture card - shows "+ Capture" button and recent capture previews
class QuickCaptureCard extends StatelessWidget {
  final List<CaptureItem> recentCaptures;

  const QuickCaptureCard({
    super.key,
    required this.recentCaptures,
  });

  String _getCaptureTypeLabel(CaptureType type) {
    switch (type) {
      case CaptureType.note:
        return 'Note';
      case CaptureType.thought:
        return 'Thought';
      case CaptureType.idea:
        return 'Idea';
      case CaptureType.quote:
        return 'Quote';
    }
  }

  String _truncateContent(String content, int maxLength) {
    if (content.length <= maxLength) {
      return content;
    }
    return '${content.substring(0, maxLength)}...';
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<PowerHouseCardTokens>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (tokens == null) {
      throw StateError('PowerHouseCardTokens not found in theme');
    }

    final previews = recentCaptures.take(2).toList();

    return Card(
      elevation: tokens.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.radius),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CapturePage()),
          );
        },
        borderRadius: BorderRadius.circular(tokens.radius),
        child: Padding(
          padding: tokens.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Capture',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const CapturePage()),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Capture'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: previews.isEmpty
                    ? Center(
                        child: Text(
                          'No captures yet',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: previews.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12), // ignore: unnecessary_underscores
                        itemBuilder: (context, index) {
                          final capture = previews[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getCaptureTypeLabel(capture.type),
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _truncateContent(capture.content, 60),
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurface.withValues(alpha: 0.8),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
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

