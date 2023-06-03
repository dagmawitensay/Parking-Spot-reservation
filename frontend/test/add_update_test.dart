import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/bloc/compound_event.dart';
import 'package:frontend/compounds/data_provider/compound_data_provider.dart';
import 'package:frontend/compounds/data_provider/compound_local_data_provider.dart';
import 'package:frontend/compounds/models/compound.dart';
import 'package:frontend/compounds/repository/compound_repository.dart';
import 'package:frontend/compounds/screens/compound_add_update.dart';
import 'package:frontend/compounds/screens/compound_route.dart';
import 'package:frontend/localDatabase/connectivity_checking.dart';

void main() {
  testWidgets('AddUpdateCompound widget test', (WidgetTester tester) async {
    Compound? createdCompound;

    final connectivityChecker = ConnectivityChecks();
    final compoundDataProvider = CompoundDataProvider();
    final compoundLocalDataProvider = CompoundLocalDataProvider();
    final compoundRepository = CompoundRepository(
      compoundDataProvider,
      compoundLocalDataProvider,
      connectivityChecker,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CompoundBloc>(
          create: (_) => CompoundBloc(compoundRepository: compoundRepository),
          child: Builder(
            builder: (context) => Scaffold(
              body: AddUpdateCompound(
                args: CompoundArgument(edit: false),
                onSave: (compound) {
                  createdCompound = compound;
                  context.read<CompoundBloc>().add(CompoundCreate(compound));
                },
              ),
            ),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'Test Compound');
    await tester.enterText(find.byType(TextFormField), 'Test Region');
    await tester.enterText(find.byType(TextFormField), 'Test Wereda');
    await tester.enterText(find.byType(TextFormField), 'Test Zone');
    await tester.enterText(find.byType(TextFormField), 'Test Kebele');
    await tester.enterText(find.byType(TextFormField), '10');
    await tester.enterText(find.byType(TextFormField), '10');
    await tester.enterText(find.byType(TextFormField), '20');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(createdCompound, isNotNull);
    expect(createdCompound!.name, 'Test Compound');
    expect(createdCompound!.Region, 'Test Region');
    expect(createdCompound!.Wereda, 'Test Wereda');
    expect(createdCompound!.Zone, 'Test Zone');
    expect(createdCompound!.Kebele, 'Test Kebele');
    expect(createdCompound!.SlotPricePerHour, 10);
    expect(createdCompound!.availableSpots, 10);
    expect(createdCompound!.totalSpots, 20);
    expect(createdCompound!.ownerId, isNull);

    expect(find.byType(AddUpdateCompound), findsNothing);
  });
}
