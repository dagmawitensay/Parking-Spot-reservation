import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/bloc/compound_event.dart';
import 'package:frontend/compounds/screens/compound_detail.dart';
import 'package:frontend/compounds/models/compound.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';

class MockCompoundBloc extends Mock implements CompoundBloc {}

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('CompoundDetail', () {
    late Compound compound;
    late MockCompoundBloc compoundBloc;
    late MockGoRouter goRouter;
    late CompoundDetail compoundDetail;

    setUp(() {
      compound = Compound(/* ... */);
      compoundBloc = MockCompoundBloc();
      goRouter = MockGoRouter();
      compoundDetail = CompoundDetail(compound: compound);

      when(compoundBloc.add(any)).thenReturn(null);
    });

    testWidgets('should display compound details correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CompoundBloc>.value(
            value: compoundBloc,
            child: compoundDetail,
          ),
        ),
      );

      expect(find.text(compound.name), findsOneWidget);
      expect(
        find.text('SpotPricePerHour: ${compound.SlotPricePerHour}'),
        findsOneWidget,
      );
      expect(find.text('Region: ${compound.Region}'), findsOneWidget);
      expect(find.text('Wereda: ${compound.Wereda}'), findsOneWidget);
      expect(find.text('Zone: ${compound.Zone}'), findsOneWidget);
      expect(find.text('Kebele: ${compound.Kebele}'), findsOneWidget);
      expect(find.text('Total spots: ${compound.totalSpots}'), findsOneWidget);
    });

    testWidgets('should navigate to edit screen when edit button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CompoundBloc>.value(
            value: compoundBloc,
            child: compoundDetail,
          ),
        ),
      );

      final editButtonFinder = find.byIcon(Icons.edit);
      expect(editButtonFinder, findsOneWidget);

      await tester.tap(editButtonFinder);
      await tester.pumpAndSettle();

      verify(goRouter.go('/addUpdateCompound',
          extra: CompoundArgument(compound: compound, edit: true))).called(1);
    });

    testWidgets('should delete compound and navigate to home screen when delete button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CompoundBloc>.value(
            value: compoundBloc,
            child: compoundDetail,
          ),
        ),
      );

      final deleteButtonFinder = find.byIcon(Icons.delete);
      expect(deleteButtonFinder, findsOneWidget);

      await tester.tap(deleteButtonFinder);
      await tester.pumpAndSettle();

      verify(compoundBloc.add(CompoundDelete(compound.id ?? 0))).called(1);
      verify(goRouter.goNamed('home')).called(1);
    });

    // Write more test cases to cover the behavior of CompoundDetail
  });
}
