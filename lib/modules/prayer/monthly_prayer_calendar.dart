import 'package:flutter/material.dart';
import '../../core/theme/powerhouse_colors.dart';
import '../../core/theme/theme_extensions.dart';

/// Monthly prayer calendar - displays prayer completion status for each day
class MonthlyPrayerCalendar extends StatelessWidget {
  final Map<String, String> monthStatus; // localDate -> 'complete' | 'partial' | 'none'
  final int year;
  final int month;

  const MonthlyPrayerCalendar({
    super.key,
    required this.monthStatus,
    required this.year,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<PowerHouseCardTokens>();
    final textTheme = Theme.of(context).textTheme;

    if (tokens == null) {
      throw StateError('PowerHouseCardTokens not found in theme');
    }

    // Get first day of month and number of days
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);
    final daysInMonth = lastDay.day;
    
    // Get weekday of first day (1 = Monday, 7 = Sunday)
    final firstWeekday = firstDay.weekday;

    // Build calendar grid
    final List<Widget> dayWidgets = [];

    // Add weekday headers
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    for (final weekday in weekdays) {
      dayWidgets.add(
        Center(
          child: Text(
            weekday,
            style: textTheme.bodySmall?.copyWith(
              color: PowerHouseColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    // Add empty cells for days before the first day of the month
    for (int i = 1; i < firstWeekday; i++) {
      dayWidgets.add(const SizedBox.shrink());
    }

    // Add day cells
    for (int day = 1; day <= daysInMonth; day++) {
      final dateStr = _formatDate(year, month, day);
      final status = monthStatus[dateStr] ?? 'none';
      dayWidgets.add(_buildDayCell(context, day, status, textTheme));
    }

    return Card(
      elevation: tokens.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.radius),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(tokens.radius),
          color: PowerHouseColors.prayerGreenMuted.withValues(alpha: 0.2),
        ),
        child: Padding(
          padding: tokens.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_getMonthName(month)} $year',
                style: textTheme.titleMedium?.copyWith(
                  color: PowerHouseColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.0,
                ),
                itemCount: dayWidgets.length,
                itemBuilder: (context, index) => dayWidgets[index],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem(
                    context,
                    'All prayers',
                    PowerHouseColors.prayerGreenDeep,
                    textTheme,
                  ),
                  const SizedBox(width: 16),
                  _buildLegendItem(
                    context,
                    'Partial',
                    PowerHouseColors.prayerGreenMedium,
                    textTheme,
                  ),
                  const SizedBox(width: 16),
                  _buildLegendItem(
                    context,
                    'None',
                    PowerHouseColors.prayerGreenMuted,
                    textTheme,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayCell(
    BuildContext context,
    int day,
    String status,
    TextTheme textTheme,
  ) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case 'complete':
        backgroundColor = PowerHouseColors.prayerGreenDeep;
        textColor = Colors.white;
        break;
      case 'partial':
        backgroundColor = PowerHouseColors.prayerGreenMedium;
        textColor = Colors.white;
        break;
      case 'none':
      default:
        backgroundColor = PowerHouseColors.prayerGreenMuted;
        textColor = PowerHouseColors.textSecondary;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          '$day',
          style: textTheme.bodySmall?.copyWith(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(
    BuildContext context,
    String label,
    Color color,
    TextTheme textTheme,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: PowerHouseColors.textSecondary,
          ),
        ),
      ],
    );
  }

  String _formatDate(int year, int month, int day) {
    final yearStr = year.toString().padLeft(4, '0');
    final monthStr = month.toString().padLeft(2, '0');
    final dayStr = day.toString().padLeft(2, '0');
    return '$yearStr-$monthStr-$dayStr';
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}

