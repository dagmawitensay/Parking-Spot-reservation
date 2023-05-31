import 'package:frontend/reservation/models/reservation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReservationDataProvider {
  final baseUrl =
      'http://localhost:3000/reservation'; // Replace with your API URL

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

  Future<void> createReservation(Reservation reservation) async {
    final url = Uri.parse('$baseUrl/reservations');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(reservation.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception(
          'Failed to create reservation. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateReservation(Reservation reservation) async {
    final url = Uri.parse('$baseUrl/reservations/${reservation.id}');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(reservation.toJson()),
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
