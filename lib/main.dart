import 'package:flutter/material.dart';

void main() {
  runApp(const PrayerTimesApp());
}

class PrayerTimesApp extends StatelessWidget {
  const PrayerTimesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prayer Times',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 24),
          bodyMedium: TextStyle(fontSize: 18),
          bodySmall: TextStyle(fontSize: 14),
          titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      home: const PrayerTimesPage(),
    );
  }
}

class PrayerTimesPage extends StatelessWidget {
  const PrayerTimesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeaderCard(context),
            const SizedBox(height: 10),
            _buildValidUntilNote(context),
            Expanded(
              child: _buildPrayerTimesList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'July 16, 2024',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
              ),
              Text(
                'Muharram 10, 1446 AH',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                'Colombo, Sri Lanka',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                'Shafi\'i',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).primaryColorDark,
                    fontStyle: FontStyle.italic,
                  ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValidUntilNote(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            color: Theme.of(context).primaryColorDark,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Until July 22, 2024',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontStyle: FontStyle.italic,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTimesList(BuildContext context) {
    final prayerTimes = [
      {'name': 'Fajr', 'time': '4:15 AM'},
      {'name': 'Sunrise', 'time': '5:45 AM'},
      {'name': 'Dhuhr', 'time': '1:00 PM'},
      {'name': 'Asr', 'time': '4:30 PM'},
      {'name': 'Maghrib', 'time': '8:15 PM'},
      {'name': 'Isha', 'time': '9:45 PM'},
    ];

    return ListView.builder(
      itemCount: prayerTimes.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: PrayerTimeWidget(
            name: prayerTimes[index]['name']!,
            time: prayerTimes[index]['time']!,
          ),
        );
      },
    );
  }
}

class PrayerTimeWidget extends StatelessWidget {
  final String name;
  final String time;

  const PrayerTimeWidget({
    super.key,
    required this.name,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              _getIconForPrayer(name),
              color: Theme.of(context).primaryColorDark,
              size: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              time,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForPrayer(String prayerName) {
    switch (prayerName) {
      case 'Fajr':
        return Icons.brightness_2;
      case 'Sunrise':
        return Icons.wb_sunny;
      case 'Dhuhr':
        return Icons.brightness_5;
      case 'Asr':
        return Icons.brightness_4;
      case 'Maghrib':
        return Icons.brightness_3;
      case 'Isha':
        return Icons.nightlight_round;
      default:
        return Icons.access_time;
    }
  }
}