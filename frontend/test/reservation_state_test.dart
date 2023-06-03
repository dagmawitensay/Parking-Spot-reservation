import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/reservation/bloc/states/reservation_state.dart';
import 'package:frontend/reservation/models/reservation.dart';

void main() {
  group('ReservationLoading', () {
    test('props should be empty', () {
      final state = ReservationLoading();
      expect(state.props, []);
    });
  });

  group('ParkingSpotInital', () {
    test('props should be empty', () {
      final state = ParkingSpotInital();
      expect(state.props, []);
    });
  });

  group('ParkingSpotsLoading', () {
    test('props should be empty', () {
      final state = ParkingSpotsLoading();
      expect(state.props, []);
    });
  });

  group('ParkingSpotsSucess', () {
    test('props should contain parkingSpotsData', () {
      final parkingSpotsData = [
        {'spotId': 1, 'status': 'available'},
        {'spotId': 2, 'status': 'available'},
      ];
      final state = ParkingSpotsSucess(parkingSpotsData);
      expect(state.props, [parkingSpotsData]);
    });
  });

  group('ParkingSpotFailure', () {
    test('props should contain errorMessage', () {
      final errorMessage = 'Failed to load parking spots';
      final state = ParkingSpotFailure(errorMessage);
      expect(state.props, [errorMessage]);
    });
  });

  group('PriceCalculated', () {
    test('props should be empty', () {
      final price = 10.0;
      final state = PriceCalculated(price);
      expect(state.props, []);
    });
  });

  group('ReservationSuccess', () {
    test('props should contain reservation', () {
      final reservation = Reservation(
          id: 1,
          startTime: '10:00 AM',
          endTime: '11:00 AM',
          spotId: 23,
          userId: 12);
      final state = ReservationSuccess(reservation);
      expect(state.props, [reservation]);
    });
  });

  group('ReservationFailure', () {
    test('props should contain errorMessage', () {
      final errorMessage = 'Failed to create reservation';
      final state = ReservationFailure(errorMessage);
      expect(state.props, [errorMessage]);
    });
  });
}
