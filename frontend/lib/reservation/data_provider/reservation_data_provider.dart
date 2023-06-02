import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/reservation/models/reservation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';

class ReservationDataProvider {
  final baseUrl = 'http://localhost:3000/reservations';
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  Future hasAvailableSpots(compoundId, startTime, endTime) async {
    String? token = await storage.read(key: 'token');
    print(token);
    //int userId = int.parse(JwtDecoder.decode(token!)['sub']);
    final http.Response response =
        await http.post(Uri.parse('$baseUrl/$compoundId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'user_id': 1,
              'start_time': startTime,
              'end_time': endTime,
            }));

    if (response.statusCode == 201) {
      print(response.body);
      final value = json.decode(response.body)['parkingSpots'];
      print('value is');
      print(value);
      return value;
    } else {
      throw Exception('Can not get available spots data');
    }
  }

  Future calculatePrice(compoundId, startTime, endTime) async {
    final response = await http
        .get(Uri.parse('http://localhost:3000/parking-compounds/$compoundId'));

    if (response.statusCode == 200) {
      final price = double.parse(jsonDecode(response.body)['price']);
      DateTime time1 = DateTime.parse(startTime);
      DateTime time2 = DateTime.parse(endTime);

      Duration timeDifference = time2.difference(time1);

      double hoursDifference = timeDifference.inMinutes / 60;

      double totalPrice = hoursDifference * price;

      return totalPrice;
    } else {
      throw Exception(
          'Can not find compouond data of compoupnd with id: $compoundId');
    }
  }

  Future<List<Reservation>> getReservationsForUser(String userId) async {
    final url = Uri.parse('$baseUrl/reservations?userId=$userId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      final reservations = jsonData
          .map((reservation) => Reservation.fromJson(reservation))
          .toList();
      return reservations;
    } else {
      throw Exception(
          'Failed to fetch reservations. Status code: ${response.statusCode}');
    }
  }

  Future<Reservation> createReservation(String startTime, String endTime,
      double price, String plateNo, int spotId) async {
    String? token = await storage.read(key: 'token');
    if (token != null) {
      int user_id = JwtDecoder.decode(token)['sub'];
    }

    final response = await http.post(
      Uri.parse('http://localhost:3000/reservations/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'user_id': 1,
        'spot_id': spotId,
        'start_time': startTime,
        'end_time': endTime,
        // 'plateNo': plateNo,
        // 'totalPrice': price
      }),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      return Reservation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Failed to create reservation. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateReservation(Reservation reservation) async {
    final url = Uri.parse('$baseUrl/reservations/${reservation.id}');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(reservation),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to update reservation. Status code: ${response.statusCode}');
    }
  }

  Future<void> cancelReservation(String reservationId) async {
    final url = Uri.parse('$baseUrl/reservations/$reservationId');

    final response = await http.delete(url);

    if (response.statusCode != 204) {
      throw Exception(
          'Failed to cancel reservation. Status code: ${response.statusCode}');
    }
  }

  Future<List<Reservation>> getAllReservations() async {
    final url = Uri.parse('$baseUrl/reservations');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List<dynamic>;
      final reservations = jsonData
          .map((reservation) => Reservation.fromJson(reservation))
          .toList();
      
      return reservations;
      
    } else {
      
      throw Exception(
          'Failed to fetch all reservations. Status code: ${response.statusCode}');
      
    }
  }
}
