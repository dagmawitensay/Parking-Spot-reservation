import 'package:test/test.dart';
import 'package:frontend/reservation/models/parking_spot.dart';

void main() {
  group('ParkingSpot', () {
    test('should create a ParkingSpot instance from JSON', () {
      // Prepare
      final json = {'id': 1, 'compound_id': 1};

      // Execute
      final parkingSpot = ParkingSpot.fromJson(json);

      // Verify
      expect(parkingSpot.id, json['id']);
      expect(parkingSpot.compoundId, json['compound_id']);
    });
  });
}
