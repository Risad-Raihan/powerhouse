import 'package:flutter/material.dart';
import '../../core/theme/theme_extensions.dart';
import 'reading_page.dart';

/// Reading item tile - displays a single reading item in the library grid
class ReadingItemTile extends StatelessWidget {
  final ReadingItemTileModel model;

  const ReadingItemTile({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<PowerHouseCardTokens>();
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

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
          // TODO: Navigate to Reader Mode for model.item
        },
        borderRadius: BorderRadius.circular(tokens.radius),
        child: Padding(
          padding: tokens.paddingSmall,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover image placeholder
              AspectRatio(
                aspectRatio: 0.7,
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: model.item.coverImagePath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            model.item.coverImagePath!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildPlaceholderIcon(context, colorScheme);
                            },
                          ),
                        )
                      : _buildPlaceholderIcon(context, colorScheme),
                ),
              ),
              const SizedBox(height: 8),

              // Title
              Text(
                model.item.title,
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),

              // Author (if available)
              if (model.item.author != null) ...[
                Text(
                  model.item.author!,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
              ],

              // Progress bar
              if (model.progress != null) ...[
                LinearProgressIndicator(
                  value: model.progress,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.primary,
                  ),
                  minHeight: 4,
                ),
                const SizedBox(height: 8),
              ],

              const Spacer(),

              // Rating (read-only stars)
              Row(
                children: List.generate(5, (index) {
                  final starValue = index + 1;
                  final isFilled = model.rating != null && starValue <= model.rating!;
                  return Icon(
                    isFilled ? Icons.star : Icons.star_border,
                    size: 16,
                    color: isFilled
                        ? colorScheme.tertiary
                        : colorScheme.onSurface.withValues(alpha: 0.3),
                  );
                }),
              ),
              const SizedBox(height: 4),

              // Last read label
              if (model.lastReadLabel != null)
                Text(
                  model.lastReadLabel!,
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderIcon(BuildContext context, ColorScheme colorScheme) {
    return Center(
      child: Icon(
        Icons.menu_book,
        size: 48,
        color: colorScheme.onSurface.withValues(alpha: 0.3),
      ),
    );
  }
}

