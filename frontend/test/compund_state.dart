import 'package:frontend/compounds/bloc/compound_state.dart';
import 'package:frontend/compounds/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('CompoundState', () {
    test('CompoundLoading state should have empty props', () {
      final state = CompoundLoading();
      expect(state.props, isEmpty);
    });

    test('CompoundOperationSuccess state should have correct props', () {
      final compounds = [
        Compound(
            id: 1,
            name: 'Compound 1',
            Kebele: 'kebele',
            Region: 'region',
            Wereda: 'wereda',
            Zone: 'zone',
            availableSpots: 200,
            ownerId: 6,
            SlotPricePerHour: 87,
            totalSpots: 100),
      ];
      final state = CompoundOperationSuccess(compounds);
      expect(state.props, [compounds]);
    });

    test('CompoundOperationFailure state should have correct props', () {
      const error = 'Error message';
      const state = CompoundOperationFailure(error);
      expect(state.props, [error]);
    });

    test('CompoundOperationFailure state should have correct error', () {
      const error = 'Error message';
      const state = CompoundOperationFailure(error);
      expect(state.error, error);
    });
  });
}
