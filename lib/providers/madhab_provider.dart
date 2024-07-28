import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MadhabProvider extends ChangeNotifier {
  String? _madhab;

  MadhabProvider() {
    _loadMadhabPreference();
  }

  String? get madhab => _madhab;

  Future<void> _loadMadhabPreference() async {
    SharedPreferences userPreferences = await SharedPreferences.getInstance();
    _madhab = userPreferences.getString('madhab') ?? 'Shafi\'i';
    notifyListeners();
  }

  Future<void> setMadhab(String madhab) async {
    SharedPreferences userPreferences = await SharedPreferences.getInstance();
    _madhab = madhab;
    await userPreferences.setString('madhab', madhab);
    notifyListeners();
  }
}
