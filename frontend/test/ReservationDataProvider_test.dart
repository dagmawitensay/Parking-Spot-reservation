import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/reservation/data_provider/reservation_data_provider.dart';
import 'package:frontend/reservation/models/reservation.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('ReservationDataProvider', () {
    late ReservationDataProvider reservationDataProvider;
    late MockFlutterSecureStorage mockSecureStorage;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockSecureStorage = MockFlutterSecureStorage();
      mockHttpClient = MockHttpClient();
      reservationDataProvider = ReservationDataProvider();
    });

    group('hasAvailableSpots', () {
      test('should return available spots data', () async {
        // Prepare
        final compoundId = 1;
        final startTime = '2023-06-01T10:00:00Z';
        final endTime = '2023-06-01T12:00:00Z';
        final expectedResponse = [
          {'spotId': 1, 'status': 'available'},
          {'spotId': 2, 'status': 'available'},
        ];
        when(mockSecureStorage.read(key: 'token'))
            .thenAnswer((_) => Future.value('token'));
        when(mockHttpClient.post(
          Uri.parse('http://localhost:3000/reservations/$compoundId'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async =>
            http.Response(jsonEncode({'parkingSpots': expectedResponse}), 201));

        // Execute
        final result = await reservationDataProvider.hasAvailableSpots(
            compoundId, startTime, endTime);

        // Verify
        expect(result, expectedResponse);
        verify(mockSecureStorage.read(key: 'token')).called(1);
        verify(mockHttpClient.post(
          Uri.parse('http://localhost:3000/reservations/$compoundId'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            'user_id': 1,
            'start_time': startTime,
            'end_time': endTime,
          }),
        )).called(1);
      });

      test('should throw an exception on failure', () async {
        // Prepare
        final compoundId = 1;
        final startTime = '2023-06-01T10:00:00Z';
        final endTime = '2023-06-01T12:00:00Z';
        when(mockSecureStorage.read(key: 'token'))
            .thenAnswer((_) => Future.value('token'));
        when(mockHttpClient.post(
          Uri.parse('http://localhost:3000/reservations/$compoundId'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async =>
            http.Response('Can not get available spots data', 500));

        // Execute and Verify
        expect(
          () => reservationDataProvider.hasAvailableSpots(
              compoundId, startTime, endTime),
          throwsException,
        );
        verify(mockSecureStorage.read(key: 'token')).called(1);
        verify(mockHttpClient.post(
          Uri.parse('http://localhost:3000/reservations/$compoundId'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            'user_id': 1,
            'start_time': startTime,
            'end_time': endTime,
          }),
        )).called(1);
      });
    });

    group('calculatePrice', () {
      test('should return the calculated price', () async {
        // Prepare
        final compoundId = 1;
        final startTime = '2023-06-01T10:00:00Z';
        final endTime = '2023-06-01T12:00:00Z';
        final compoundResponse = http.Response(jsonEncode({'price': 10}), 200);
        final expectedPrice = 20.0;
        when(mockHttpClient.get(Uri.parse(
                'http://localhost:3000/parking-compounds/$compoundId')))
            .thenAnswer((_) async => compoundResponse);

        // Execute
        final result = await reservationDataProvider.calculatePrice(
            compoundId, startTime, endTime);

        // Verify
        expect(result, expectedPrice);
        verify(mockHttpClient.get(Uri.parse(
                'http://localhost:3000/parking-compounds/$compoundId')))
            .called(1);
      });

      test('should throw an exception on failure', () async {
        // Prepare
        final compoundId = 1;
        final startTime = '2023-06-01T10:00:00Z';
        final endTime = '2023-06-01T12:00:00Z';
        when(mockHttpClient.get(Uri.parse(
                'http://localhost:3000/parking-compounds/$compoundId')))
            .thenAnswer(
                (_) async => http.Response('Can not find compound data', 404));

        // Execute and Verify
        expect(
          () => reservationDataProvider.calculatePrice(
              compoundId, startTime, endTime),
          throwsException,
        );
        verify(mockHttpClient.get(Uri.parse(
                'http://localhost:3000/parking-compounds/$compoundId')))
            .called(1);
      });
    });

    group('getReservationsForUser', () {
      test('should return the list of reservations', () async {
        // Prepare
        final userId = '1';
        final url =
            Uri.parse('http://localhost:3000/reservations?userId=$userId');
        final response = http.Response(
            jsonEncode([
              {'id': 1, 'startTime': '10:00 AM', 'endTime': '11:00 AM'},
              {'id': 2, 'startTime': '11:00 AM', 'endTime': '12:00 PM'},
            ]),
            200);
        final expectedReservations = [
          Reservation(
              id: 1,
              startTime: '10:00 AM',
              endTime: '11:00 AM',
              spotId: 12,
              userId: 12),
          Reservation(
              id: 2,
              startTime: '11:00 AM',
              endTime: '12:00 PM',
              spotId: 12,
              userId: 12),
        ];
        when(mockHttpClient.get(url)).thenAnswer((_) async => response);

        // Execute
        final result =
            await reservationDataProvider.getReservationsForUser(userId);

        // Verify
        expect(result, expectedReservations);
        verify(mockHttpClient.get(url)).called(1);
      });

      test('should throw an exception on failure', () async {
        // Prepare
        final userId = '1';
        final url =
            Uri.parse('http://localhost:3000/reservations?userId=$userId');
        when(mockHttpClient.get(url)).thenAnswer(
            (_) async => http.Response('Failed to fetch reservations', 500));

        // Execute and Verify
        expect(
          () => reservationDataProvider.getReservationsForUser(userId),
          throwsException,
        );
        verify(mockHttpClient.get(url)).called(1);
      });
    });

    // Write unit tests for other methods in ReservationDataProvider
    // ...
  });
}
