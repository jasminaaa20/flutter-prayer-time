import 'package:flutter/material.dart';
import 'package:prayer_time/services/prayer_times_service.dart';
import 'package:prayer_time/widgets/prayer_time_header.dart';
import 'package:prayer_time/widgets/prayer_times_list.dart';
import 'package:prayer_time/widgets/valid_until_note.dart';
import 'package:prayer_time/providers/madhab_provider.dart';
import 'package:prayer_time/services/hijri_date_service.dart';
import 'package:provider/provider.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({super.key});

  @override
  PrayerTimesPageState createState() => PrayerTimesPageState();
}

class PrayerTimesPageState extends State<PrayerTimesPage> {
  final PrayerTimesService _prayerTimesService = PrayerTimesService();
  final HijriDateService _hijriDateService = HijriDateService();
  Map<String, dynamic>? _prayerTimes;
  String? _hijriDate;
  final List<String> _shafiFilter = [
    "fajr",
    "sunrise",
    "dhuhr",
    "asr",
    "maghrib",
    "isha"
  ];
  final List<String> _hanafiFilter = [
    "fajr",
    "sunrise",
    "dhuhr",
    "hanafiAsr",
    "maghrib",
    "isha"
  ];

  @override
  void initState() {
    super.initState();
    _loadPrayerTimes();
    _calculateHijriDate();
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

  Future<void> _calculateHijriDate() async {
    try {
      final hijriDate = await _hijriDateService.calculateHijriDate(DateTime.now());
      setState(() {
        _hijriDate = hijriDate;
      });
    } catch (e) {
      debugPrint('Failed to calculate Hijri date: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final madhabProvider = Provider.of<MadhabProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Times'),
        actions: [
          DropdownButton<String>(
            value: madhabProvider.madhab,
            onChanged: (String? newValue) async {
              madhabProvider.setMadhab(newValue!);
            },
            items: <String>['Shafi\'i', 'Hanafi']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: _prayerTimes == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  PrayerTimeHeader(
                    date: _prayerTimes!['date'],
                    hijriDate: _hijriDate ?? 'Calculating...',
                    city: 'Colombo, Sri Lanka',
                    madhab: madhabProvider.madhab!,
                  ),
                  const SizedBox(height: 10),
                  ValidUntilNote(endDate: _prayerTimes!['endDate']),
                  Expanded(
                    child: PrayerTimesList(
                      filteredKeys: madhabProvider.madhab == 'Shafi\'i'
                          ? _shafiFilter
                          : _hanafiFilter,
                      prayerTimes: _prayerTimes,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
