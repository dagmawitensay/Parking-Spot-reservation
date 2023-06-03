import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test/test.dart';
import 'package:frontend/reservation/repository/reservation_repository.dart';
import 'package:frontend/reservation/data_provider/reservation_data_provider.dart';
import 'package:frontend/reservation/models/reservation.dart';

class MockReservationDataProvider implements ReservationDataProvider {
  var getReservationsForUserUserId;

  get getReservationsForUserCalled => null;

  get createReservationCalled => null;

  get createReservationStartTime => null;

  get createReservationEndTime => null;

  get createReservationPlateNo => null;

  get createReservationPrice => null;

  get createReservationSpotId => null;

  @override
  Future<List<Reservation>> getReservationsForUser(String userId) async {
    // Mock implementation
    return Future.value([]);
  }

  @override
  Future<Reservation> createReservation(
      startTime, endTime, price, plateNo, spotId) async {
    // Mock implementation
    return Future.value(
        Reservation(endTime: '', startTime: '', spotId: 23, userId: 34));
  }

  Future hasReservations(compoundId, startTime, endTime) {
    // Mock implementation
    return Future.value();
  }

  @override
  Future calculatePrice(compoundId, startTime, endTime) async {
    // Mock implementation
    return Future.value();
  }

  @override
  Future<void> updateReservation(Reservation reservation) async {
    // Mock implementation
    return Future.value();
  }

  @override
  Future<void> cancelReservation(String reservationId) async {
    // Mock implementation
    return Future.value();
  }

  @override
  Future<List<Reservation>> getAllReservations() async {
    // Mock implementation
    return Future.value([]);
  }

  @override
  // TODO: implement baseUrl
  String get baseUrl => throw UnimplementedError();

  @override
  Future hasAvailableSpots(compoundId, startTime, endTime) {
    // TODO: implement hasAvailableSpots
    throw UnimplementedError();
  }

  @override
  // TODO: implement storage
  FlutterSecureStorage get storage => throw UnimplementedError();
}

void main() {
  group('ReservationRepository', () {
    late ReservationRepository repository;
    late MockReservationDataProvider dataProvider;

    setUp(() {
      dataProvider = MockReservationDataProvider();
      repository = ReservationRepository(dataProvider);
    });

    test('should call dataProvider.getReservationsForUser', () async {
      // Prepare
      final userId = '1';

      // Execute
      await repository.getReservationsForUser(userId);

      // Verify
      expect(dataProvider.getReservationsForUserCalled, true);
      expect(dataProvider.getReservationsForUserUserId, userId);
    });

    test('should call dataProvider.createReservation', () async {
      // Prepare
      final startTime = '2023-06-01T08:00:00Z';
      final endTime = '2023-06-01T10:00:00Z';
      final price = 10.0;
      final plateNo = 'ABC123';
      final spotId = 1;

      // Execute
      await repository.createReservation(
          startTime, endTime, price, plateNo, spotId);

      // Verify
      expect(dataProvider.createReservationCalled, true);
      expect(dataProvider.createReservationStartTime, startTime);
      expect(dataProvider.createReservationEndTime, endTime);
      expect(dataProvider.createReservationPrice, price);
      expect(dataProvider.createReservationPlateNo, plateNo);
      expect(dataProvider.createReservationSpotId, spotId);
    });

    // Add more tests for other methods in ReservationRepository
  });
}
