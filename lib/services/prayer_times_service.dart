import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PrayerTimesService {
  final CollectionReference _prayerTimesCollection = FirebaseFirestore.instance.collection('prayerTimes');
  
  Future<Map<String, dynamic>?> fetchCurrentPrayerTimes() async {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    QuerySnapshot snapshot = await _prayerTimesCollection
        .where('startDate', isLessThanOrEqualTo: today)
        .where('endDate', isGreaterThanOrEqualTo: today)
        .get();

    if (snapshot.docs.isNotEmpty) {
      Map<String, dynamic> dataWithDate = Map.from(snapshot.docs.first.data() as Map<String, dynamic>)
        ..addAll({'date': today});
      return dataWithDate;
    }
    return null;
  }
}