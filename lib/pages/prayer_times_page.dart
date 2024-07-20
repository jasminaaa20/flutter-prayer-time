import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_time/services/prayer_times_service.dart';
import 'package:prayer_time/widgets/prayer_time_card.dart';
import 'package:prayer_time/widgets/prayer_time_header.dart';
import 'package:prayer_time/widgets/valid_until_note.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({super.key});

  @override
  PrayerTimesPageState createState() => PrayerTimesPageState();
}

class PrayerTimesPageState extends State<PrayerTimesPage> {
  final PrayerTimesService _prayerTimesService = PrayerTimesService();
  Map<String, dynamic>? _prayerTimes;
  final List<String> _filteredKeys = [
    "fajr",
    "sunrise",
    "dhuhr",
    "asr",
    "maghrib",
    "isha"
  ];

  @override
  void initState() {
    super.initState();
    _loadPrayerTimes();
    // _prayerTimes = {
    //   "Fajr": "5:00 AM",
    //   "Sunrise": "6:15 AM",
    //   "Dhuhr": "12:00 PM",
    //   "Asr": "03:15 PM",
    //   "Maghrib": "06:00 PM",
    //   "Isha": "07:15 PM"
    // };
  }

  Future<void> _loadPrayerTimes() async {
    try {
      final data = await _prayerTimesService.fetchCurrentPrayerTimes();
      setState(() {
        _prayerTimes = data;
      });
    } catch (e) {
      debugPrint('Failed to fetch prayer times: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _prayerTimes == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
            child: Column(
              children: [
                PrayerTimeHeader(
                  date: DateFormat('dd MMMM yyyy').format(DateTime.now()),
                  hijriDate: 'Muharram 12 1446 AH',
                  city: 'Colombo, Sri Lanka',
                  madhab: 'Shafi\'i',
                ),
                const SizedBox(height:10),
                const ValidUntilNote(endDate: '26 July 2024'),
                Expanded(
                  child: ListView.builder(
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
                  )
                )
              ],
            )
          ),
    );
  }
}