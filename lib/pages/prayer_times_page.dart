import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prayer_time/services/prayer_times_service.dart';
import 'package:prayer_time/widgets/prayer_time_header.dart';
import 'package:prayer_time/widgets/prayer_times_list.dart';
import 'package:prayer_time/widgets/valid_until_note.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({super.key});

  @override
  PrayerTimesPageState createState() => PrayerTimesPageState();
}

class PrayerTimesPageState extends State<PrayerTimesPage> {
  final PrayerTimesService _prayerTimesService = PrayerTimesService();
  Map<String, dynamic>? _prayerTimes;
  String? _selectedMadhab;
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
    _loadMadhabPreference();
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

  Future<void> _loadMadhabPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _selectedMadhab = preferences.getString('madhab') ?? 'Shafi\'i';
    });
  }

  Future<void> _saveMadhabPreference(String madhab) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('madhab', madhab);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Times'),
        actions: [
          DropdownButton<String>(
            value: _selectedMadhab,
            onChanged: (String? newValue) async {
              setState(() {
                _selectedMadhab = newValue!;
              });
              await _saveMadhabPreference(newValue!);
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
                    hijriDate: 'Muharram 12 1446 AH',
                    city: 'Colombo, Sri Lanka',
                    madhab: _selectedMadhab!,
                  ),
                  const SizedBox(height: 10),
                  ValidUntilNote(endDate: _prayerTimes!['endDate']),
                  Expanded(
                    child: PrayerTimesList(
                      filteredKeys: _selectedMadhab == 'Shafi\'i'
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