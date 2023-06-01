import 'dart:convert';

import 'package:frontend/reservation/models/parking_compound.dart';
import 'package:http/http.dart' as http;

class ParkingCompoundDataProvider {
  static const String _baseUrl = 'http://localhost:3000/parking-compounds';

  Future<List<ParkingCompound>> getAllParkingCompounds() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<ParkingCompound> parkingCompounds = List<ParkingCompound>.from(
        data.map((dynamic item) => ParkingCompound.fromJson(item)),
      );
      return parkingCompounds;
    } else {
      throw Exception('Failed to load parking compounds');
    }
  }

  Future<String> getLocationById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      return data['location'];
    } else {
      throw Exception('Failed to load location');
    }
  }

  Future<double> getPriceById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      return data['price'].toDouble();
    } else {
      throw Exception('Failed to load price');
    }
  }
}
