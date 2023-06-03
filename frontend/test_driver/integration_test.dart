import 'package:integration_test/integration_test_driver.dart';
// import 'package:'
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:frontend/auth/bloc/blocs/owner_signup_bloc.dart';
import 'package:integration_test/integration_test.dart';
import 'package:frontend/main.dart' as app;  
// Future<void> main() => integrationDriver();



// class MockCompoundDataProvider extends CompoundDataProvider {

// }
void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    // testWidgets('')
  testWidgets("Testing the homepage", (WidgetTester  tester) async{
    app.main();
    await tester.pumpAndSettle();
    final compoundOwnerSignUp = find.byType(ElevatedButton).first;
    // final reserverSignUp = find.byType(ElevatedButton).last;
    await Future.delayed(const Duration(seconds: 3));

    tester.tap(compoundOwnerSignUp);
    await Future.delayed(const Duration(seconds: 3));
  await tester.pumpAndSettle();

  final firstname = find.byKey(const Key('firsname'));
  final lastname = find.byKey(const Key('lastname'));
  final username = find.byKey(const Key('username'));
   final email  = find.byKey(const Key('email'));
  final  password = find.byKey(const Key('password'));

  expect(firstname,findsOneWidget);
  expect(lastname, findsOneWidget);
  expect(username,findsOneWidget);
  expect(email, findsOneWidget);
  expect(password,findsOneWidget);

  await tester.enterText(firstname,'Ephrem');
  await tester.enterText(lastname, 'Shimels');
  await tester.enterText(username,'ephi');
  await tester.enterText(email, 'ephrem@gmail.com');
  await tester.enterText(password,'123456');
  await  tester.pumpAndSettle();

  await tester.tap(find.byKey(const Key('signupbutton')));
  await Future.delayed(const Duration(seconds: 3));

  // final signinemail = find.byKey(const Key('signin'));
  // final signi


  await tester.tap(find.byType(FloatingActionButton));
  await Future.delayed(const Duration(seconds: 2));
  
      final compoundNameField = find.byKey(const Key('Name'));
      final compoundRegionField = find.byKey(const Key('Region'));
      final compoundWeredaField = find.byKey(const Key('Wereda'));
      final compoundZoneField = find.byKey(const Key('Zone'));
      final compoundKebeleField = find.byKey(const Key('Kebele'));
      final slotPrice = find.byKey(const Key('Price Per Slot'));
      final totalSpots   = find.byKey(const Key('Total Spots'));
      final availableSpots = find.byKey(const Key('Available Spots'));

      expect(compoundNameField , findsOneWidget);
      expect(compoundRegionField, findsOneWidget);
      expect(compoundWeredaField, findsOneWidget);
      expect(compoundZoneField , findsOneWidget);
      expect(compoundKebeleField , findsOneWidget);
      expect(slotPrice, findsOneWidget);
      expect(totalSpots, findsOneWidget);
      expect(availableSpots, findsOneWidget);

      await tester.enterText(compoundKebeleField,'bole');
      await tester.enterText(compoundRegionField, 'Addis Ababa');
      await tester.enterText(compoundWeredaField, 'Arada');
      await tester.enterText(compoundZoneField , 'Arada');
      await tester.enterText(compoundKebeleField , '10');
      await tester.enterText(slotPrice, '45.60');
      await tester.enterText(totalSpots, '30');
      await tester.enterText(availableSpots, '60');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('savecompound')));

      await Future.delayed(const Duration (seconds:2));


});

}





