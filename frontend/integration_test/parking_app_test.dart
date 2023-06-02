import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/auth/bloc/blocs/authentication_bloc.dart';
import 'package:frontend/auth/bloc/blocs/owner_signup_bloc.dart';
import 'package:frontend/auth/bloc/blocs/signin_bloc.dart';
import 'package:frontend/auth/bloc/blocs/spot_reserver_signup_bloc.dart';
import 'package:frontend/auth/bloc/events/authentication_event.dart';
// import 'package:frontend/auth/bloc/events/owner_signup_event.dart';
import 'package:frontend/auth/bloc/events/signin_event.dart';
import 'package:frontend/auth/bloc/states/authenticatoin_state.dart';
// import 'package:frontend/auth/bloc/states/owner_signup_state.dart';
// import 'package:frontend/auth/bloc/states/spot_reserver_signup_event.dart';
import 'package:frontend/auth/data_provider/user_data_provider.dart';
import 'package:frontend/auth/repository/auth_repository.dart';
import 'package:frontend/auth/screens/owner_signup.dart';
import 'package:frontend/auth/screens/signin.dart';
import 'package:frontend/auth/screens/spot_reserver_signup.dart';
import 'package:frontend/compounds/bloc/compound_state.dart';
import 'package:frontend/compounds/screens/compound_list.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';
// import '../compounds/bloc_observer.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/bloc/compound_event.dart';
import 'package:frontend/compounds/data_provider/compound_data_provider.dart';
import 'package:frontend/compounds/repository/compound_repository.dart';
import 'package:frontend/compounds/screens/compound_add_update.dart';
import 'package:frontend/compounds/screens/compound_detail.dart';
import 'package:frontend/compounds/screens/compound_route.dart';
import 'package:frontend/compounds/screens/home_page.dart';
import 'package:frontend/compounds/data_provider/compound_local_data_provider.dart';

class MockCompoundDataProvider extends CompoundDataProvider {
  
}
void main(){
  group( "The whole app widgets",(){
    testWidgets('')
  })
  
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
