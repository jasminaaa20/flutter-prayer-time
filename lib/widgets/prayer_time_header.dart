import 'package:flutter/material.dart';

class PrayerTimeHeader extends StatelessWidget {
  final String city;
  final String fromDate;
  final String toDate;

  const PrayerTimeHeader({super.key, required this.city, required this.fromDate, required this.toDate});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '$fromDate - $toDate',
                style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: Text(
                city,
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            // const SizedBox(height: 8.0),
            // Text(
            //   'from: $fromDate to: $toDate',
            //   style: const TextStyle(fontSize: 20.0),
            // ),
          ],
        ),
      ),
    );
  }
}
