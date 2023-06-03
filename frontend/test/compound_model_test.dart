import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/compound/models/compound.dart';

void main() {
  group('Compound', () {
    test('fromJson creates a Compound object from JSON', () {
      final json = {
        'id': 1,
        'name': 'Compound 1',
        'Region': 'Region 1',
        'Wereda': 'Wereda 1',
        'Zone': 'Zone 1',
        'Kebele': 'Kebele 1',
        'price': '10.0',
        'available_spots': 5,
        'total_spots': 10,
        'owner_id': 1,
      };

      final compound = Compound.fromJson(json);

      expect(compound.id, equals(1));
      expect(compound.name, equals('Compound 1'));
      expect(compound.Region, equals('Region 1'));
      expect(compound.Wereda, equals('Wereda 1'));
      expect(compound.Zone, equals('Zone 1'));
      expect(compound.Kebele, equals('Kebele 1'));
      expect(compound.SlotPricePerHour, equals(10.0));
      expect(compound.availableSpots, equals(5));
      expect(compound.totalSpots, equals(10));
      expect(compound.ownerId, equals(1));
    });

    test('toMap converts a Compound object to a map', () {
      final compound = Compound(
        id: 1,
        name: 'Compound 1',
        Region: 'Region 1',
        Wereda: 'Wereda 1',
        Zone: 'Zone 1',
        Kebele: 'Kebele 1',
        SlotPricePerHour: 10.0,
        availableSpots: 5,
        totalSpots: 10,
        ownerId: 1,
      );

      final map = compound.toMap();

      expect(map['id'], equals(1));
      expect(map['name'], equals('Compound 1'));
      expect(map['Region'], equals('Region 1'));
      expect(map['Wereda'], equals('Wereda 1'));
      expect(map['Zone'], equals('Zone 1'));
      expect(map['Kebele'], equals('Kebele 1'));
      expect(map['price'], equals(10.0));
      expect(map['available_spots'], equals(5));
      expect(map['total_spots'], equals(10));
      expect(map['owner_id'], equals(1));
    });
  });
}
