import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:frontend/reservation/bloc/events/reservation_event.dart';

void main() {
  group('ParkingSpotLoad', () {
    test('props should contain compoundId, date, startTime, and endTime', () {
      final compoundId = 1;
      final date = DateTime.now();
      final startTime = '10:00 AM';
      final endTime = '11:00 AM';
      final event = ParkingSpotLoad(compoundId, date, startTime, endTime);

      expect(event.props, [compoundId, date, startTime, endTime]);
    });
  });

  group('StartTimeChanged', () {
    test('props should contain startTime', () {
      final startTime = TimeOfDay(hour: 10, minute: 0);
      final event = StartTimeChanged(startTime);

      expect(event.props, [startTime]);
    });
  });

  group('EndTimeChanged', () {
    test('props should contain endTime', () {
      final endTime = TimeOfDay(hour: 11, minute: 0);
      final event = EndTimeChanged(endTime);

      expect(event.props, [endTime]);
    });
  });

  group('Next', () {
    test('props should contain compound_id, startTime, endTime, and date', () {
      final compoundId = 1;
      final startTime = '10:00 AM';
      final endTime = '11:00 AM';
      final date = DateTime.now();
      final event = Next(compoundId, startTime, endTime, date);

      expect(event.props, [compoundId, startTime, endTime, date]);
    });
  });

  group('PriceCalculation', () {
    test('props should contain startTime, endTime, and compoundId', () {
      final startTime = '10:00 AM';
      final endTime = '11:00 AM';
      final compoundId = 1;
      final event = PriceCalculation(
          startTime: startTime, endTime: endTime, compoundId: compoundId);

      expect(event.props, [startTime, endTime, compoundId]);
    });
  });

  group('ReserveSpot', () {
    test('props should contain startTime, endTime, spot_id, price, and plateNo',
        () {
      final startTime = '10:00 AM';
      final endTime = '11:00 AM';
      final spotId = 1;
      final price = 10.0;
      final plateNo = 'ABC123';
      final event = ReserveSpot(
          startTime: startTime,
          endTime: endTime,
          spot_id: spotId,
          price: price,
          plateNo: plateNo);

      expect(event.props, [startTime, endTime, spotId, price, plateNo]);
    });
  });
}
