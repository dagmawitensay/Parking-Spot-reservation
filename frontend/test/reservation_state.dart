
import 'package:test/test.dart';
import 'package:frontend/reservation/models/reservation.dart';

void main() {
  group('Reservation', () {
    test('should create a Reservation instance from JSON', () {
      // Prepare
      final json = {
        'id': 1,
        'start_time': '2023-06-01T08:00:00Z',
        'end_time': '2023-06-01T10:00:00Z',
        'user_id': 1,
        'parking_spot_id': 2,
      };

      // Execute
      final reservation = Reservation.fromJson(json);

      // Verify
      expect(reservation.id, json['id']);
      expect(reservation.startTime, json['start_time']);
      expect(reservation.endTime, json['end_time']);
      expect(reservation.userId, json['user_id']);
      expect(reservation.spotId, json['parking_spot_id']);
    });

    test('should create a Reservation instance with null id', () {
      // Prepare
      final json = {
        'start_time': '2023-06-01T08:00:00Z',
        'end_time': '2023-06-01T10:00:00Z',
        'user_id': 1,
        'parking_spot_id': 2,
      };

      // Execute
      final reservation = Reservation.fromJson(json);

      // Verify
      expect(reservation.id, isNull);
      expect(reservation.startTime, json['start_time']);
      expect(reservation.endTime, json['end_time']);
      expect(reservation.userId, json['user_id']);
      expect(reservation.spotId, json['parking_spot_id']);
    });
  });
}
=======
import 'package:test/test.dart';
import 'package:frontend/reservation/models/reservation.dart';

void main() {
  group('Reservation', () {
    test('should create a Reservation instance from JSON', () {
      // Prepare
      final json = {
        'id': 1,
        'start_time': '2023-06-01T08:00:00Z',
        'end_time': '2023-06-01T10:00:00Z',
        'user_id': 1,
        'parking_spot_id': 2,
      };

      // Execute
      final reservation = Reservation.fromJson(json);

      // Verify
      expect(reservation.id, json['id']);
      expect(reservation.startTime, json['start_time']);
      expect(reservation.endTime, json['end_time']);
      expect(reservation.userId, json['user_id']);
      expect(reservation.spotId, json['parking_spot_id']);
    });

    test('should create a Reservation instance with null id', () {
      // Prepare
      final json = {
        'start_time': '2023-06-01T08:00:00Z',
        'end_time': '2023-06-01T10:00:00Z',
        'user_id': 1,
        'parking_spot_id': 2,
      };

      // Execute
      final reservation = Reservation.fromJson(json);

      // Verify
      expect(reservation.id, isNull);
      expect(reservation.startTime, json['start_time']);
      expect(reservation.endTime, json['end_time']);
      expect(reservation.userId, json['user_id']);
      expect(reservation.spotId, json['parking_spot_id']);
    });
  });
}
>>>>>>> 1d802ade27bb303a1fdbadf33eec1c124f59a3c5
