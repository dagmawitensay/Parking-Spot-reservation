import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/auth/bloc/blocs/owner_signup_bloc.dart';
import 'package:frontend/auth/bloc/events/owner_signup_event.dart';
import 'package:frontend/auth/models/auth.dart';
import 'package:frontend/pages/owner_signup_page.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';

class MockCompoundOwnerSignupBloc extends Mock implements CompoundOwnerSignupBloc {}

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('OwnerSignupPage', () {
    late MockCompoundOwnerSignupBloc compoundOwnerSignupBloc;
    late MockGoRouter goRouter;

    setUp(() {
      compoundOwnerSignupBloc = MockCompoundOwnerSignupBloc();
      goRouter = MockGoRouter();
    });

    testWidgets('renders OwnerSignupPage correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: OwnerSignupPage(),
        ),
      );

      expect(find.text('Owner Sign Up'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(5));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Already have an account? Login'), findsOneWidget);
    });

    testWidgets('triggers owner sign up event and navigation when form is submitted with valid data',
        (WidgetTester tester) async {
      when(compoundOwnerSignupBloc.state).thenReturn(OwnerSignUpSucess());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CompoundOwnerSignupBloc>.value(
            value: compoundOwnerSignupBloc,
            child: GoRouter(
              goRouter: goRouter,
              errorPageBuilder: (_, __, ___) => Container(),
              notFoundPageBuilder: (_) => Container(),
              onNamed: (_, __, ___) {},
              onUnknownRoute: (_) => Container(),
              routes: {},
            ),
          ),
        ),
      );

      await tester.enterText(find.byKey(const Key('firstNameField')), 'John');
      await tester.enterText(find.byKey(const Key('lastNameField')), 'Doe');
      await tester.enterText(find.byKey(const Key('usernameField')), 'johndoe');
      await tester.enterText(find.byKey(const Key('emailField')), 'john.doe@example.com');
      await tester.enterText(find.byKey(const Key('passwordField')), 'password');

      await tester.tap(find.text('Sign Up'));
      await tester.pump();

      verify(
        compoundOwnerSignupBloc.add(
          OwnerSignUp(
            owner: CompoundOwner(
              firstName: 'John',
              lastName: 'Doe',
              username: 'johndoe',
              email: 'john.doe@example.com',
              password: 'password',
            ),
          ),
        ),
      ).called(1);

      verify(goRouter.goNamed('signin')).called(1);
    });

    testWidgets('displays error message when owner sign up fails', (WidgetTester tester) async {
      when(compoundOwnerSignupBloc.state).thenReturn(OwnerSignUpFailure('Failed to sign up'));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CompoundOwnerSignupBloc>.value(
            value: compoundOwnerSignupBloc,
            child: OwnerSignupPage(),
          ),
        ),
      );

      expect(find.text('Failed to sign up'), findsOneWidget);
    });
  });
}