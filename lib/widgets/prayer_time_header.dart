import 'package:flutter/material.dart';

class PrayerTimeHeader extends StatelessWidget {
  final String date;
  final String hijriDate;
  final String city;
  final String madhab;

  const PrayerTimeHeader({
    super.key, 
    required this.date, 
    required this.hijriDate, 
    required this.city, 
    required this.madhab
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                date,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
              ),
              Text(
                hijriDate,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                city,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                madhab,
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
}
