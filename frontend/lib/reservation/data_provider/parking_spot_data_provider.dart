import 'dart:convert';
import 'package:frontend/reservation/models/parking_spot.dart';
import 'package:http/http.dart' as http;

class ParkingSpotDataProvider {
  static const String baseUrl = 'http://localhost:3000/parking_spot_id';

  Future<List<ParkingSpot>> fetchParkingSpots(int page) async {
    final response = await http.get(Uri.parse('$baseUrl?page=$page'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<ParkingSpot> parkingSpots = List<ParkingSpot>.from(
        data.map((dynamic item) => ParkingSpot.fromJson(item)),
      );
      return parkingSpots;
    } else {
      throw Exception('Failed to fetch parking spots');
    }
  }
}
