import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:prayer_time/pages/prayer_times_page.dart';
import 'package:prayer_time/providers/madhab_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PrayerTimesApp());
}

class PrayerTimesApp extends StatelessWidget {
  const PrayerTimesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MadhabProvider(),
      child: ShadApp.material(
        title: 'Prayer Times',
        debugShowCheckedModeBanner: false,
        theme: ShadThemeData(
          colorScheme: const ShadZincColorScheme.light(), brightness: Brightness.light,
          textTheme: ShadTextTheme(
            family: 'Roboto',
            h1: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),

        // theme: ThemeData(
        //   primarySwatch: Colors.cyan,
        //   fontFamily: 'Roboto',
        //   textTheme: const TextTheme(
        //     bodyLarge: TextStyle(fontSize: 24),
        //     bodyMedium: TextStyle(fontSize: 18),
        //     bodySmall: TextStyle(fontSize: 14),
        //     titleLarge: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
        //   ),
        // ),
        home: const PrayerTimesPage(),
      ),
    );
  }
}
