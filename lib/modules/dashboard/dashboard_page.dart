import 'package:flutter/material.dart';
import 'dashboard_service.dart';
import 'dashboard_models.dart';
import 'dashboard_grid.dart';
import '../reading/reading_repository.dart';
import '../prayer/prayer_repository.dart';

/// Dashboard page - home screen of PowerHouse
/// 
/// Uses a single StreamBuilder to watch DashboardData from DashboardService.
/// Handles loading, error, and data states.
class DashboardPage extends StatelessWidget {
  final DashboardService service;
  final ReadingRepository readingRepository;
  final PrayerRepository prayerRepository;

  const DashboardPage({
    super.key,
    required this.service,
    required this.readingRepository,
    required this.prayerRepository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PowerHouse'),
      ),
      body: StreamBuilder<DashboardData>(
        stream: service.watchDashboard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading dashboard: ${snapshot.error}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('No data available'),
            );
          }

          return DashboardGrid(
            data: snapshot.data!,
            readingRepository: readingRepository,
            prayerRepository: prayerRepository,
          );
        },
      ),
    );
  }
}

