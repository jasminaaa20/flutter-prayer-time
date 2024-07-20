import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PrayerTimesService {
  static const String _baseUrl = 'https://api.aladhan.com/v1/timingsByCity';
  final CollectionReference _prayerTimesCollection = FirebaseFirestore.instance.collection('prayerTimes');

  Future<Map<String, dynamic>> fetchPrayerTimes() async {
    // Get current date
    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    // Get current location
    Position position = await _determinePosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];

    String city = place.locality ?? 'Colombo';
    String country = place.country ?? 'Sri Lanka';

    // Construct the API URL
    final url = Uri.parse('$_baseUrl?city=$city&country=$country&date=$currentDate');

    // Make the GET request
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load prayer times');
    }
  }
  
  Future<Map<String, dynamic>?> fetchCurrentPrayerTimes() async {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    QuerySnapshot snapshot = await _prayerTimesCollection
        .where('startDate', isLessThanOrEqualTo: today)
        .where('endDate', isGreaterThanOrEqualTo: today)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data() as Map<String, dynamic>?;
    }
    return null;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
