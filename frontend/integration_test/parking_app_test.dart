import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/auth/bloc/blocs/owner_signup_bloc.dart';
import 'package:integration_test/integration_test.dart';
import 'package:frontend/main.dart' as app;  

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

  final 


  await tester.tap(find.byType(FloatingActionButton));
  await Future.delayed(const Duration(seconds: 2));
  
      final compoundNameField = find.byKey(const Key('Name'));
      final compoundRegionField = find.byKey(const Key('Region'));
      final compoundWeredaField = find.byKey(const Key('Wereda'));
      final compoundZoneField = find.byKey(const Key('Zone'));
      final compoundKebeleField = find.byKey(const Key('Kebele'));
      final slotPrice = find.byKey(const Key('Price Per Slot'));
      final totalSpots   = find.byKey(const Key('Total Spots'));
      final availableSpots = find.byKey(const Key('Availbable Spots'));

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

});

  
}





// import 'package:flutter_test/flutter_test.dart';
// import 'package:your_app/auth_bloc.dart';
// import 'package:your_app/auth_event.dart';
// import 'package:your_app/auth_repository.dart';
// import 'package:your_app/auth_state.dart';
// import 'package:your_app/data_provider/auth_data_provider.dart';

// void main() {
//   testWidgets('Authentication Integration Test', (tester) async {
//     // Create a mock data provider for authentication
//     final authDataProvider = MockAuthDataProvider();

//     // Create an instance of the repository with the mock data provider
//     final authRepository = AuthRepository(authDataProvider);

//     // Create an instance of the BLoC with the repository
//     final authBloc = AuthBloc(authRepository);

//     // Create a widget for testing, such as the app's login page
//     final testWidget = MaterialApp(
//       home: LoginPage(authBloc),
//     );

//     // Pump the widget
//     await tester.pumpWidget(testWidget);

//     // Perform the login process
//     authBloc.add(LoginEvent('username', 'password'));
//     await tester.pump();

//     // Expect the state to be authenticated after successful login
//     expect(authBloc.state, emitsInOrder([AuthState.loading, AuthState.authenticated]));
//   });
// }

// // Mock data provider for testing
// class MockAuthDataProvider extends AuthDataProvider {
//   @override
//   Future<bool> login(String username, String password) async {
//     // Simulate a successful login
//     return true;
//   }
// }
