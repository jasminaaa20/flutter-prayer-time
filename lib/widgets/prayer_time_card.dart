import 'package:flutter/material.dart';

class PrayerTimeCard extends StatelessWidget {
  final String prayerName;
  final String prayerTime;

  const PrayerTimeCard({
    super.key, 
    required this.prayerName, 
    required this.prayerTime
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
              _getIconForPrayer(prayerName),
              color: Theme.of(context).primaryColorDark,
              size: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                prayerName,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              prayerTime,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForPrayer(String prayerName) {
    switch (prayerName) {
      case 'fajr':
        return Icons.brightness_2;
      case 'sunrise':
        return Icons.wb_sunny;
      case 'dhuhr':
        return Icons.brightness_5;
      case 'asr' || 'hanafiAsr':
        return Icons.brightness_4;
      case 'maghrib':
        return Icons.brightness_3;
      case 'isha':
        return Icons.nightlight_round;
      default:
        return Icons.access_time;
    }
  }
}