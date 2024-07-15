import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_time/services/prayer_times_service.dart';
import 'package:prayer_time/widgets/prayer_time_card.dart';
import 'package:prayer_time/widgets/prayer_time_header.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({super.key});

  @override
  PrayerTimesPageState createState() => PrayerTimesPageState();
}

class PrayerTimesPageState extends State<PrayerTimesPage> {
  final PrayerTimesService _prayerTimesService = PrayerTimesService();
  Map<String, dynamic>? _prayerTimes;
  String? _city;
  final String _fromDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final String _toDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final List<String> _filteredKeys = [
    "Fajr",
    "Sunrise",
    "Dhuhr",
    "Asr",
    "Maghrib",
    "Isha"
  ];

  @override
  void initState() {
    super.initState();
    _loadPrayerTimes();
  }

  Future<void> _loadPrayerTimes() async {
    try {
      final data = await _prayerTimesService.fetchPrayerTimes();
      setState(() {
        _prayerTimes = data['timings'];
        _city = 'Colombo';
      });
    } catch (e) {
      print('Failed to fetch prayer times: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Prayer Times'),
      //   centerTitle: true,
      // ),
      body: _prayerTimes == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    PrayerTimeHeader(
                      city: _city ?? 'Unknown',
                      fromDate: _fromDate,
                      toDate: _toDate,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _filteredKeys.length,
                        itemBuilder: (context, index) {
                          String key = _filteredKeys[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: PrayerTimeCard(
                              prayerName: key,
                              prayerTime: _prayerTimes![key],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ),
    );
  }
}