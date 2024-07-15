import 'package:flutter/material.dart';
import 'package:prayer_time/pages/prayer_times_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prayer Times App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PrayerTimesPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
