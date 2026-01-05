import 'package:flutter/material.dart';
import '../../core/database/app_database.dart';
import '../../core/database/converters/enum_converters.dart';
import '../../core/theme/powerhouse_colors.dart';
import '../../core/theme/theme_extensions.dart';
import '../../core/utils/time_utils.dart';
import 'prayer_repository.dart';

/// Daily prayer tracker - interactive chips for marking prayers
class DailyPrayerTracker extends StatelessWidget {
  final List<PrayerEntry> todayPrayers;
  final PrayerRepository repository;

  const DailyPrayerTracker({
    super.key,
    required this.todayPrayers,
    required this.repository,
  });

  PrayerEntry? _findPrayer(PrayerType type) {
    try {
      return todayPrayers.firstWhere((p) => p.prayer == type);
    } catch (_) {
      return null;
    }
  }

  bool _isPrayerCompleted(PrayerType type) {
    final entry = _findPrayer(type);
    if (entry == null) return false;
    return entry.status == PrayerStatus.prayed ||
        entry.status == PrayerStatus.prayedLate;
  }

  Future<void> _togglePrayer(BuildContext context, PrayerType prayer) async {
    final isCompleted = _isPrayerCompleted(prayer);
    final now = nowUtc();
    final localDate = currentLocalDate();

    if (isCompleted) {
      // Already completed - no undo UI yet, so do nothing
      return;
    }

    // Mark as prayed
    await repository.upsertPrayerEntry(
      prayer: prayer,
      status: PrayerStatus.prayed,
      loggedAtUtc: now,
      localDate: localDate,
    );
  }

  String _getPrayerName(PrayerType type) {
    switch (type) {
      case PrayerType.fajr:
        return 'Fajr';
      case PrayerType.dhuhr:
        return 'Dhuhr';
      case PrayerType.asr:
        return 'Asr';
      case PrayerType.maghrib:
        return 'Maghrib';
      case PrayerType.isha:
        return 'Isha';
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<PowerHouseCardTokens>();
    final textTheme = Theme.of(context).textTheme;

    if (tokens == null) {
      throw StateError('PowerHouseCardTokens not found in theme');
    }

    final prayers = [
      PrayerType.fajr,
      PrayerType.dhuhr,
      PrayerType.asr,
      PrayerType.maghrib,
      PrayerType.isha,
    ];

    return Card(
      elevation: tokens.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(tokens.radius),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(tokens.radius),
          color: PowerHouseColors.prayerGreenMuted.withValues(alpha: 0.3),
        ),
        child: Padding(
          padding: tokens.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mark Your Prayers',
                style: textTheme.titleMedium?.copyWith(
                  color: PowerHouseColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: prayers.map((prayer) {
                  final isCompleted = _isPrayerCompleted(prayer);
                  return _PrayerChip(
                    prayer: prayer,
                    name: _getPrayerName(prayer),
                    isCompleted: isCompleted,
                    onTap: () => _togglePrayer(context, prayer),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrayerChip extends StatefulWidget {
  final PrayerType prayer;
  final String name;
  final bool isCompleted;
  final VoidCallback onTap;

  const _PrayerChip({
    required this.prayer,
    required this.name,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  State<_PrayerChip> createState() => _PrayerChipState();
}

class _PrayerChipState extends State<_PrayerChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _colorAnimation = ColorTween(
      begin: PowerHouseColors.prayerGreenLight,
      end: PowerHouseColors.prayerGreenDeep,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.isCompleted) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(_PrayerChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCompleted != oldWidget.isCompleted) {
      if (widget.isCompleted) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: widget.isCompleted
                    ? _colorAnimation.value
                    : PowerHouseColors.prayerGreenLight,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: widget.isCompleted
                      ? PowerHouseColors.prayerGreenDeep
                      : PowerHouseColors.prayerGreenMedium,
                  width: widget.isCompleted ? 2 : 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.isCompleted)
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.white,
                    )
                  else
                    Icon(
                      Icons.radio_button_unchecked,
                      size: 18,
                      color: PowerHouseColors.prayerGreenDeep,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    widget.name,
                    style: textTheme.bodyMedium?.copyWith(
                      color: widget.isCompleted
                          ? Colors.white
                          : PowerHouseColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

