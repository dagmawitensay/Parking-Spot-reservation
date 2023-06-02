import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/auth/bloc/blocs/signin_bloc.dart';
import 'package:frontend/auth/bloc/events/signin_event.dart';
import 'package:frontend/auth/bloc/states/signin_state.dart';
import 'package:frontend/auth/models/auth.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';

class MockSignInBloc extends Mock implements SignInBloc {}

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('LoginPage', () {
    late MockSignInBloc signInBloc;
    late MockGoRouter goRouter;

    setUp(() {
      signInBloc = MockSignInBloc();
      goRouter = MockGoRouter();
    });

    testWidgets('renders LoginPage correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginPage(),
        ),
      );

      // Verify that the LoginPage renders the necessary widgets
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.text("Forgot password?"), findsOneWidget);
      expect(find.text("Don't have an account? Sign up"), findsOneWidget);
    });

    testWidgets('triggers sign-in event and navigation when form is submitted with valid data',
        (WidgetTester tester) async {
      when(signInBloc.state).thenReturn(SignInInital());
      when(signInBloc.add(any)).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SignInBloc>.value(
            value: signInBloc,
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

      // Enter email and password
      await tester.enterText(find.byKey(const Key('emailField')), 'test@example.com');
      await tester.enterText(find.byKey(const Key('passwordField')), 'password');

      // Tap the login button
      await tester.tap(find.text('Login'));
      await tester.pump();

      // Verify that the sign-in event is triggered with the correct user credentials
      verify(signInBloc.add(SignIn(user: User(email: 'test@example.com', password: 'password')))).called(1);

      // Verify that the navigation occurs to the 'compoundList' route
      verify(goRouter.goNamed('compoundList')).called(1);
    });

    testWidgets('displays error message when sign-in fails', (WidgetTester tester) async {
      when(signInBloc.state).thenReturn(const SignInFailure('Invalid email or password'));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SignInBloc>.value(
            value: signInBloc,
            child: LoginPage(),
          ),
        ),
      );

      // Enter email and password
      await tester.enterText(find.byKey(const Key('emailField')), 'test@example.com');
      await tester.enterText(find.byKey(const Key('passwordField')), 'password');

      // Tap the login button
      await tester.tap(find.text('Login'));
      await tester.pump();

      // Verify that the error message is displayed
      expect(find.text('Invalid email or password'), findsOneWidget);
    });
  });
}
