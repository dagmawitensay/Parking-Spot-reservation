import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/auth/bloc/blocs/authentication_bloc.dart';
import 'package:frontend/auth/data_provider/user_data_provider.dart';
import 'package:frontend/auth/repository/auth_repository.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserDataProvider extends Mock implements UserDataProvider {}

class MockCompoundBloc extends Mock implements CompoundBloc {}

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('AddUpdateCompound', () {
    late CompoundArgument args;
    late MockAuthenticationBloc authenticationBloc;
    late MockAuthRepository authRepository;
    late MockUserDataProvider userDataProvider;
    late MockCompoundBloc compoundBloc;
    late MockGoRouter goRouter;
    late AddUpdateCompound addUpdateCompound;

    setUp(() {
      args = CompoundArgument(/* ... */);
      authenticationBloc = MockAuthenticationBloc();
      authRepository = MockAuthRepository();
      userDataProvider = MockUserDataProvider();
      compoundBloc = MockCompoundBloc();
      goRouter = MockGoRouter();
      addUpdateCompound = AddUpdateCompound(args: args);

      when(authRepository.getUserDataProvider())
          .thenReturn(userDataProvider);
      when(compoundBloc.add(any)).thenReturn(null);
    });

    testWidgets('should show Edit Compound title when in edit mode',
        (WidgetTester tester) async {
      args = CompoundArgument(edit: true);
      addUpdateCompound = AddUpdateCompound(args: args);

      await tester.pumpWidget(
        MaterialApp(
          home: addUpdateCompound,
        ),
      );
      expect(find.text('Edit Compound'), findsOneWidget);
      expect(find.text('Add New Compound'), findsNothing);
    });

    testWidgets('should show Add New Compound title when not in edit mode',
        (WidgetTester tester) async {
      args = CompoundArgument(edit: false);
      addUpdateCompound = AddUpdateCompound(args: args);

      await tester.pumpWidget(
        MaterialApp(
          home: addUpdateCompound,
        ),
      );
      expect(find.text('Add New Compound'), findsOneWidget);
      expect(find.text('Edit Compound'), findsNothing);
    });

    // Write more test cases to cover the behavior of AddUpdateCompound
  });
}
