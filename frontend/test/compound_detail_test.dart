import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/bloc/compound_event.dart';
import 'package:frontend/compounds/models/compound.dart';
import 'package:frontend/compounds/screens/compound_add_update.dart';
import 'package:frontend/compounds/screens/compound_detail.dart';
import 'package:frontend/compounds/screens/compound_route.dart';
import 'package:mockito/mockito.dart';

class MockCompoundBloc extends Mock implements CompoundBloc {}

void main() {
  group('CompoundDetail', () {
    late CompoundBloc compoundBloc;
    late Compound compound;

    setUp(() {
      compoundBloc = MockCompoundBloc();
      compound = Compound(
        id: 1,
        name: 'Test Compound',
        SlotPricePerHour: 10,
        Region: 'Test Region',
        Wereda: 'Test Wereda',
        Zone: 'Test Zone',
        Kebele: 'Test Kebele',
        totalSpots: 20,
        availableSpots: 100,
        ownerId: 45,
      );
    });

    testWidgets('should render correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<CompoundBloc>.value(
          value: compoundBloc,
          child: MaterialApp(
            home: CompoundDetail(compound: compound),
          ),
        ),
      );

      expect(find.text('Test Region'), findsOneWidget);
      expect(find.text('Name: Test Compound'), findsOneWidget);
      expect(find.text('SpotPricePerHour: 10'), findsOneWidget);
      expect(find.text('Details'), findsOneWidget);
      expect(find.text('Region: Test Region'), findsOneWidget);
      expect(find.text('Wereda: Test Wereda'), findsOneWidget);
      expect(find.text('Zone: Test Zone'), findsOneWidget);
      expect(find.text('Kebele: Test Kebele'), findsOneWidget);
      expect(find.text('Total spots: 20'), findsOneWidget);
    });

    testWidgets('should navigate to edit screen on edit button press',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<CompoundBloc>.value(
          value: compoundBloc,
          child: MaterialApp(
            home: CompoundDetail(compound: compound),
            routes: {
              '/addUpdateCompound': (BuildContext context) => AddUpdateCompound(
                    args: CompoundArgument(compound: compound, edit: true),
                    onSave: (compound) {},
                  ),
            },
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      expect(find.text('Edit Compound'), findsOneWidget);
      expect(find.text('Test Compound'), findsOneWidget);
      expect(find.text('Test Region'), findsOneWidget);
      expect(find.text('Test Wereda'), findsOneWidget);
      expect(find.text('Test Zone'), findsOneWidget);
      expect(find.text('Test Kebele'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
      expect(find.text('20'), findsOneWidget);
    });

    testWidgets('should delete compound on delete button press',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<CompoundBloc>.value(
          value: compoundBloc,
          child: MaterialApp(
            home: CompoundDetail(compound: compound),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      verify(compoundBloc.add(CompoundDelete(compound.id ?? 0)));
      expect(find.text('Test Region'), findsNothing);
    });
  });
}
