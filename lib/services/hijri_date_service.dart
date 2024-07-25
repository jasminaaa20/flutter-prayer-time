import 'package:cloud_firestore/cloud_firestore.dart';

class HijriDateService {
  final CollectionReference _hijriMonthStartsCollection =
      FirebaseFirestore.instance.collection('hijriMonthStarts');

  Future<Map<String, dynamic>?> fetchHijriMonthStarts(int gregorianYear) async {
    DocumentSnapshot snapshot = await _hijriMonthStartsCollection.doc(gregorianYear.toString()).get();
    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>?;
    }
    return null;
  }

  Future<String> calculateHijriDate(DateTime gregorianDate) async {
    int year = gregorianDate.year;
    int previousYear = year - 1;

    // Fetch data for the current year and the previous year to handle overlap
    Map<String, dynamic>? monthStartsCurrentYear = await fetchHijriMonthStarts(year);
    Map<String, dynamic>? monthStartsPreviousYear = await fetchHijriMonthStarts(previousYear);

    if (monthStartsCurrentYear == null && monthStartsPreviousYear == null) {
      throw Exception('No data available for the provided date.');
    }

    // Merge the data for easier processing
    Map<String, dynamic> monthStarts = {};
    if (monthStartsPreviousYear != null) {
      monthStarts.addAll(monthStartsPreviousYear);
    }
    if (monthStartsCurrentYear != null) {
      monthStarts.addAll(monthStartsCurrentYear);
    }

    String hijriDate = '';
    DateTime closestStartDate = DateTime.parse('1970-01-01'); // Arbitrary small date
    DateTime monthStartDate = DateTime.parse('1970-01-01');
    String month = '';

    monthStarts.forEach((monthName, startDate) {
      monthStartDate = DateTime.parse(startDate);
      if (gregorianDate.isAfter(monthStartDate) || gregorianDate.isAtSameMomentAs(monthStartDate)) {
        if (monthStartDate.isAfter(closestStartDate) || monthStartDate.isAtSameMomentAs(closestStartDate)) {
          closestStartDate = monthStartDate;
          month = monthName;
        }
      }
    });

    int daysPassed = gregorianDate.difference(closestStartDate).inDays;
    hijriDate = '${daysPassed + 1} $month AH';

    return hijriDate;
  }
}
