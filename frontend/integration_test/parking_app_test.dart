import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/auth/repository/auth_repository.dart';
import 'package:frontend/compounds/bloc_observer.dart';
import 'package:frontend/compounds/data_provider/compound_data_provider.dart';
import 'package:frontend/compounds/data_provider/compound_local_data_provider.dart';
import 'package:frontend/compounds/repository/compound_repository.dart';
import 'package:frontend/compounds/screens/compound_add_update.dart';
import 'package:frontend/localDatabase/connectivity_checking.dart';
import 'package:frontend/main.dart';
import 'package:frontend/reservation/data_provider/reservation_data_provider.dart';
import 'package:frontend/reservation/repository/reservation_repository.dart';
import 'package:frontend/sync_manager/syncing.dart';
// import 'package:frontend/auth/bloc/blocs/owner_signup_bloc.dart';
import 'package:integration_test/integration_test.dart';
import 'package:frontend/compounds/screens/compound_list.dart';
import 'package:frontend/auth/data_provider/user_data_provider.dart';
import 'package:frontend/auth/models/auth.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:frontend/main.dart' as app;
import 'package:frontend/auth/screens/owner_signup.dart';
import 'package:mockito/mockito.dart';
import 'package:url_strategy/url_strategy.dart';  

class MockUserDataProvider extends Mock implements UserDataProvider{
   final FlutterSecureStorage storage = new FlutterSecureStorage();

   Future<CompoundOwner> signUpCompoundOwner(CompoundOwner owner) async {
   CompoundOwner testOwner = CompoundOwner(
      username:'mock', 
      email: 'testOwner@gmail.com', 
      password:'owner1',
      firstName: 'testOwner',
      lastName: 'testOwner'
      );
      const token = '';
     const role = 'owner';
      persitstToken(token, role);
      return testOwner; 
}


 Future<SpotReservingUser> signUpSpotReserver (SpotReservingUser reserver) async{

  SpotReservingUser testReserver = SpotReservingUser(

    username: 'mockReserve',
    email: 'testReserver@gmail.com',
    password: 'Reserver',
    firstName: 'testReserver',
    lastName:  'testReserver'
  );
   const token = '';
   const role = 'reserver';
   persitstToken(token, role);
   return testReserver;

      }

  Future<User> OwnersignIn(User user) async {
  User testUser = User(
    email:'testOwner@gmail.com',
     password: 'owner1'
     );
     const token = '';
     const role = 'owner';
     persitstToken(token,role);
     return testUser;
}

Future<User> ReserversignIn(User user) async {
  User testUser = User(
    email:'testReserver@gmail.com',
     password: 'Reserver'
     );
     const token = '';
     const role = 'reserver';
     persitstToken(token,role);
     return testUser;
}

}
class MockCompoundDataProvider extends CompoundDataProvider {}

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    // testWidgets('')
  testWidgets("Testing the homepage", (WidgetTester  tester) async{
    // app.main();
    void main() {
  MockUserDataProvider userdataProvider = MockUserDataProvider();
  CompoundDataProvider compoundDataProvider = CompoundDataProvider();
  SyncManager syncManager = SyncManager();
  CompoundLocalDataProvider localProvider = CompoundLocalDataProvider();
  ConnectivityChecks connectivitychecker = ConnectivityChecks();

  final AuthRepository authRepository = AuthRepository(userdataProvider);
  final CompoundRepository compoundRepository = CompoundRepository(
      compoundDataProvider, localProvider, connectivitychecker);
  final ReservationRepository reservationRepository =
      ReservationRepository(ReservationDataProvider());
  syncManager.syncingManager();
  Bloc.observer = MyBlocObserver();
  setPathUrlStrategy();

  runApp(AuthApp(
    authRepository: authRepository,
    compoundRepository: compoundRepository,
    reservationRepository: reservationRepository,
  ));
}

main();

    await tester.pumpAndSettle();
    final compoundOwnerSignUp = find.byType(ElevatedButton).first;
    // final reserverSignUp = find.byType(ElevatedButton).last;
    await Future.delayed(const Duration(seconds: 3));

    tester.tap(compoundOwnerSignUp);
    await Future.delayed(const Duration(seconds: 3));
  await tester.pumpAndSettle();

  expect(find.byType( OwnerSignupPage) ,findsOneWidget);

  final firstname = find.byKey(const Key('firstname'));
  final lastname = find.byKey(const Key('lastname'));
  final username = find.byKey(const Key('username'));
   final email  = find.byKey(const Key('email'));
  final  password = find.byKey(const Key('password'));

  // expect(firstname,findsOneWidget);
  // expect(lastname, findsOneWidget);
  // expect(username,findsOneWidget);
  // expect(email, findsOneWidget);
  // expect(password,findsOneWidget);


  await tester.enterText(firstname,'testOwner');
  await tester.enterText(lastname, 'testOwner');
  await tester.enterText(username,'mock');
  await tester.enterText(email, 'testOwner@gmail.com');
  await tester.enterText(password,'owner1');
  await  tester.pumpAndSettle();

  await tester.tap(find.byKey(const Key('signupbutton')));
  await Future.delayed(const Duration(seconds: 3));

  // final signinemail = find.byKey(const Key('signin'));
  // final signi

  expect(find.byType(AddUpdateCompound), findsOneWidget);

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

      // expect(compoundNameField , findsOneWidget);
      // expect(compoundRegionField, findsOneWidget);
      // expect(compoundWeredaField, findsOneWidget);
      // expect(compoundZoneField , findsOneWidget);
      // expect(compoundKebeleField , findsOneWidget);
      // expect(slotPrice, findsOneWidget);
      // expect(totalSpots, findsOneWidget);
      // expect(availableSpots, findsOneWidget);
      

      await tester.enterText(compoundNameField,'bole');
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
      expect(find.byType(CompoundList),findsOneWidget);
});

}





