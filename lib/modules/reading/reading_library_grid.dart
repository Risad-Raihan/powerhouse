import 'package:flutter/material.dart';
import '../../core/theme/theme_extensions.dart';
import 'reading_page.dart';
import 'reading_item_tile.dart';

/// Reading library grid - displays all reading items in a responsive grid
class ReadingLibraryGrid extends StatelessWidget {
  final List<ReadingItemTileModel> items;

  const ReadingLibraryGrid({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<PowerHouseCardTokens>();
    final textTheme = Theme.of(context).textTheme;

    if (tokens == null) {
      throw StateError('PowerHouseCardTokens not found in theme');
    }

    if (items.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(tokens.paddingSmall.horizontal),
        child: Center(
          child: Text(
            'No reading items yet',
            style: textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Tablet-friendly grid: 2-4 columns based on width
        int crossAxisCount;
        if (constraints.maxWidth >= 1200) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth >= 900) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth >= 600) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: tokens.paddingSmall.horizontal / 2,
            mainAxisSpacing: tokens.paddingSmall.horizontal / 2,
            childAspectRatio: 0.7, // Taller cards for book covers
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ReadingItemTile(model: items[index]);
          },
        );
      },
    );
  }
}

