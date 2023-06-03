import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/home_page.dart';
import 'package:mockito/mockito.dart';

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  group('HomePage', () {
    late MockGoRouter goRouter;
    late HomePage homePage;

    setUp(() {
      goRouter = MockGoRouter();
      homePage = HomePage();
    });

    testWidgets('should display welcome message and buttons correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: homePage,
        ),
      );

      expect(find.text('Welcome to the Parking Spot Reservation App'),
          findsOneWidget);
      expect(
        find.text('Find and reserve parking spots conveniently!'),
        findsOneWidget,
      );

      final ownerSignupButtonFinder = find.text('Sign Up as Compound Owner');
      expect(ownerSignupButtonFinder, findsOneWidget);

      final reserverSignupButtonFinder = find.text('Sign Up as Spot User');
      expect(reserverSignupButtonFinder, findsOneWidget);

      final signInButtonFinder = find.text('Already have an account? Sign In');
      expect(signInButtonFinder, findsOneWidget);
    });

    testWidgets('should navigate to owner signup screen when owner signup button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: homePage,
        ),
      );

      final ownerSignupButtonFinder = find.text('Sign Up as Compound Owner');
      expect(ownerSignupButtonFinder, findsOneWidget);

      await tester.tap(ownerSignupButtonFinder);
      await tester.pumpAndSettle();

      verify(goRouter.goNamed('ownerSignup')).called(1);
    });

    testWidgets('should navigate to reserver signup screen when reserver signup button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: homePage,
        ),
      );

      final reserverSignupButtonFinder = find.text('Sign Up as Spot User');
      expect(reserverSignupButtonFinder, findsOneWidget);

      await tester.tap(reserverSignupButtonFinder);
      await tester.pumpAndSettle();

      verify(goRouter.goNamed('reserverSignup')).called(1);
    });

    testWidgets('should navigate to signin screen when signin button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: homePage,
        ),
      );

      final signInButtonFinder = find.text('Already have an account? Sign In');
      expect(signInButtonFinder, findsOneWidget);

      await tester.tap(signInButtonFinder);
      await tester.pumpAndSettle();

      verify(goRouter.goNamed('signin')).called(1);
    });

    // Write more test cases to cover the behavior of HomePage
  });
}
