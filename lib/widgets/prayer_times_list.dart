import 'package:flutter/material.dart';
import 'package:prayer_time/widgets/prayer_time_card.dart';

class PrayerTimesList extends StatelessWidget {
  const PrayerTimesList({
    super.key,
    required List<String> filteredKeys,
    required Map<String, dynamic>? prayerTimes,
  }) : _filteredKeys = filteredKeys, _prayerTimes = prayerTimes;

  final List<String> _filteredKeys;
  final Map<String, dynamic>? _prayerTimes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _filteredKeys.length,
      itemBuilder: (context, index) {
        String key = _filteredKeys[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: PrayerTimeCard(
            prayerName: key,
            prayerTime: _prayerTimes![key],
          ),
        );
      }
    );
  }
}