import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prayer_time/pages/prayer_times_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          titleLarge: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
        ),
      ),
      home: const PrayerTimesPage(),
    );
  }
}
