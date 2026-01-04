import 'package:flutter/material.dart';
import 'core/database/app_database.dart';
import 'core/theme/powerhouse_theme.dart';
import 'modules/dashboard/dashboard_page.dart';
import 'modules/prayer/prayer_repository.dart';
import 'modules/reading/reading_repository.dart';
import 'modules/capture/capture_repository.dart';
import 'modules/gamification/gamification_repository.dart';
import 'modules/insights/insights_repository.dart';
import 'modules/dashboard/dashboard_service.dart';

void main() {
  runApp(const PowerHouseApp());
}

class PowerHouseApp extends StatefulWidget {
  const PowerHouseApp({super.key});

  @override
  State<PowerHouseApp> createState() => _PowerHouseAppState();
}

class _PowerHouseAppState extends State<PowerHouseApp> {
  late final AppDatabase _database;
  late final PrayerRepository _prayerRepository;
  late final ReadingRepository _readingRepository;
  late final CaptureRepository _captureRepository;
  late final GamificationRepository _gamificationRepository;
  late final InsightsRepository _insightsRepository;
  late final DashboardService _dashboardService;

  @override
  void initState() {
    super.initState();
    _database = AppDatabase();
    _prayerRepository = PrayerRepository(_database);
    _readingRepository = ReadingRepository(_database);
    _captureRepository = CaptureRepository(_database);
    _gamificationRepository = GamificationRepository(_database);
    _insightsRepository = InsightsRepository(_database);
    _dashboardService = DashboardService(
      prayerRepository: _prayerRepository,
      readingRepository: _readingRepository,
      captureRepository: _captureRepository,
      gamificationRepository: _gamificationRepository,
      insightsRepository: _insightsRepository,
    );
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PowerHouse',
      theme: PowerHouseTheme.lightTheme,
      home: DashboardPage(
        service: _dashboardService,
        readingRepository: _readingRepository,
      ),
    );
  }
}
