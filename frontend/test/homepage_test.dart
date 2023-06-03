import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/compounds/screens/home_page.dart';

void main() {
  testWidgets('HomePage widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    expect(find.text('Parking Spot Reservation App'), findsOneWidget);

    expect(find.text('Welcome to the Parking Spot Reservation App'),
        findsOneWidget);
    expect(find.text('Sign Up as Compound Owner'), findsOneWidget);
    expect(find.text('Sign Up as Spot User'), findsOneWidget);

    expect(find.text('Already have an account? Sign In'), findsOneWidget);

    await tester.tap(find.text('Sign Up as Compound Owner'));
    await tester.pump();

    expect(find.text('ownerSignup'), findsOneWidget);

    await tester.tap(find.text('Sign Up as Spot User'));
    await tester.pump();

    expect(find.text('reserverSignup'), findsOneWidget);

    await tester.tap(find.text('Already have an account? Sign In'));
    await tester.pump();

    expect(find.text('signin'), findsOneWidget);
  });
}
