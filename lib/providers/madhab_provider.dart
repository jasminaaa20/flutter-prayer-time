import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MadhabProvider extends ChangeNotifier {
  String? _madhab;

  MadhabProvider() {
    _loadMadhabPreference();
  }

  String? get madhab => _madhab;

  Future<void> _loadMadhabPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _madhab = prefs.getString('madhab') ?? 'Shafi\'i';
    notifyListeners();
  }

  Future<void> setMadhab(String madhab) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _madhab = madhab;
    await prefs.setString('madhab', madhab);
    notifyListeners();
  }
}
