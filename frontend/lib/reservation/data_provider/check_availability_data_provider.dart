import 'dart:convert';
import 'package:http/http.dart' as http;

class ReservationDataProvider {
  static const String baseUrl = 'http://localhost:3000/parking_spot';

  Future<bool> checkAvailability(
      int parkingSpotId, DateTime startTime, DateTime endTime) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/reservations?parking_spot_id=$parkingSpotId&start_time=${startTime.toIso8601String()}&end_time=${endTime.toIso8601String()}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.isEmpty;
    } else {
      throw Exception('Failed to check availability');
    }
  }
}
