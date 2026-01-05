import 'package:flutter/material.dart';
import 'dashboard_models.dart';
import '../../core/theme/theme_extensions.dart';
import 'cards/daily_focus_card.dart';
import 'cards/prayer_status_card.dart';
import 'cards/reading_now_card.dart';
import 'cards/xp_progress_card.dart';
import 'cards/quick_capture_card.dart';
import 'cards/insights_card.dart';
import '../reading/reading_repository.dart';
import '../prayer/prayer_repository.dart';

/// Dashboard grid - tablet-first responsive layout
/// 
/// Uses LayoutBuilder to determine column count:
/// - Landscape tablet: 2 columns
/// - Portrait tablet: adaptive 1-2 columns based on width threshold
class DashboardGrid extends StatelessWidget {
  final DashboardData data;
  final ReadingRepository readingRepository;
  final PrayerRepository prayerRepository;

  const DashboardGrid({
    super.key,
    required this.data,
    required this.readingRepository,
    required this.prayerRepository,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<PowerHouseCardTokens>();
    if (tokens == null) {
      throw StateError('PowerHouseCardTokens not found in theme');
    }

    final spacing = tokens.paddingSmall.horizontal / 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > constraints.maxHeight;
        final isTablet = constraints.maxWidth >= 600;
        
        int crossAxisCount;
        if (isLandscape && isTablet) {
          crossAxisCount = 2;
        } else if (isTablet) {
          crossAxisCount = constraints.maxWidth >= 800 ? 2 : 1;
        } else {
          crossAxisCount = 1;
        }

        return GridView(
          padding: EdgeInsets.all(spacing),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: 1.2,
          ),
          children: [
            DailyFocusCard(localDate: data.localDate),
            PrayerStatusCard(
              todaysPrayers: data.todaysPrayers,
              prayerRepository: prayerRepository,
            ),
            ReadingNowCard(
              currentReading: data.currentReading,
              todayReadingSessions: data.todayReadingSessions,
              readingRepository: readingRepository,
            ),
            XpProgressCard(
              todayXp: data.todayXp,
              totalXp: data.totalXp,
            ),
            QuickCaptureCard(recentCaptures: data.recentCaptures),
            InsightsCard(activeInsights: data.activeInsights),
          ],
        );
      },
    );
  }
}

