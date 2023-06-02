// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:frontend/auth/bloc/blocs/authentication_bloc.dart';
// import 'package:frontend/auth/bloc/events/authentication_event.dart';
// import 'package:frontend/auth/bloc/states/authenticatoin_state.dart';
// import 'package:frontend/auth/data_provider/user_data_provider.dart';
// import 'package:frontend/auth/repository/auth_repository.dart';
// import 'package:frontend/auth/screens/signin.dart';
// import 'package:frontend/compounds/bloc/compound_bloc.dart';
// import 'package:frontend/compounds/bloc/compound_event.dart';
// import 'package:frontend/compounds/models/compound.dart';
// import 'package:frontend/compounds/screens/compound_add_update.dart';
// import 'package:frontend/compounds/screens/compound_route.dart';
// import 'package:go_router/go_router.dart';

// class MockAuthenticationBloc extends MockBloc<AuthenticationEvent, AuthenticationState> implements AuthenticationBloc {}

// void main() {
//   group('AddUpdateCompound Widget Test', () {
//     late MockAuthenticationBloc authenticationBloc;
//     late CompoundBloc compoundBloc;
//     final compoundArgument = CompoundArgument(edit: false);
    
//     setUp(() {
//       authenticationBloc = MockAuthenticationBloc();
//       compoundBloc = CompoundBloc();
//     });
    
//     tearDown(() {
//       authenticationBloc.close();
//       compoundBloc.close();
//     });
    
//     testWidgets('Renders the AddUpdateCompound widget with a form', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MultiBlocProvider(
//           providers: [
//             BlocProvider<AuthenticationBloc>.value(value: authenticationBloc),
//             BlocProvider<CompoundBloc>.value(value: compoundBloc),
//           ],
//           child: MaterialApp(
//             home: AddUpdateCompound(args: compoundArgument),
//           ),
//         ),
//       );

//       expect(find.text('Add New Compound'), findsOneWidget);
//       expect(find.byType(TextFormField), findsNWidgets(8));
//       expect(find.byType(ElevatedButton), findsNWidgets(2));
//     });

//     testWidgets('Save button saves the compound and navigates to compound list', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MultiBlocProvider(
//           providers: [
//             BlocProvider<AuthenticationBloc>.value(value: authenticationBloc),
//             BlocProvider<CompoundBloc>.value(value: compoundBloc),
//           ],
//           child: MaterialApp(
//             home: AddUpdateCompound(args: compoundArgument),
//           ),
//         ),
//       );

//       // Enter some values in the form
//       await tester.enterText(find.byKey(Key('name')), 'Test Compound');
//       await tester.enterText(find.byKey(Key('region')), 'Test Region');
//       await tester.enterText(find.byKey(Key('wereda')), 'Test Wereda');
//       await tester.enterText(find.byKey(Key('zone')), 'Test Zone');
//       await tester.enterText(find.byKey(Key('kebele')), 'Test Kebele');
//       await tester.enterText(find.byKey(Key('slotPricePerHour')), '10');
//       await tester.enterText(find.byKey(Key('totalSpots')), '100');
//       await tester.enterText(find.byKey(Key('availableSpots')), '50');

//       // Tap the save button
//       await tester.tap(find.byIcon(Icons.save));
//       await tester.pump();

//       // Verify that the CompoundCreate event is dispatched to the CompoundBloc
//       expect(compoundBloc.state, isA<CompoundCreate>());

//       // Verify that the navigation to the compound list is triggered
//       expect(GoRouter.of(tester.element(find.byType(AddUpdateCompound))), isNotNull);
//       expect(GoRouter.of(tester.element(find.byType(AddUpdateCompound)))!.location, '/compoundList');
//     });
//   });
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:frontend/auth/bloc/blocs/authentication_bloc.dart';
// import 'package:frontend/auth/bloc/states/authenticatoin_state.dart';
// import 'package:frontend/auth/data_provider/user_data_provider.dart';
// import 'package:frontend/auth/repository/auth_repository.dart';
// import 'package:frontend/compounds/screens/compound_add_update.dart';
// import 'package:frontend/compounds/screens/compound_route.dart';

// void main() {
//   group('AddUpdateCompound', () {
//     late AuthenticationBloc authenticationBloc;
//     late AuthRepository authRepository;

//     setUp(() {
//       authRepository = AuthRepository(UserDataProvider());
//       authenticationBloc = AuthenticationBloc(authRepository: authRepository);
//     });

//     tearDown(() {
//       authenticationBloc.close();
//     });

//     testWidgets('Renders form when authenticated', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         BlocProvider<AuthenticationBloc>.value(
//           value: authenticationBloc,
//           child: MaterialApp(
//             home: AddUpdateCompound(args: CompoundArgument(edit: false)),
//           ),
//         ),
//       );

//       expect(find.byType(TextFormField), findsNWidgets(7));
//       expect(find.byType(ElevatedButton), findsOneWidget);
//     });

//     testWidgets('Redirects to signin page when unauthenticated',
//         (WidgetTester tester) async {
//       authenticationBloc.add(AuthenticationUnauthenticated());

//       await tester.pumpWidget(
//         BlocProvider<AuthenticationBloc>.value(
//           value: authenticationBloc,
//           child: MaterialApp(
//             home: AddUpdateCompound(args: CompoundArgument(edit: false)),
//           ),
//         ),
//       );

//       await tester.pumpAndSettle();

//       expect(find.byType(SignInPage), findsOneWidget);
//     });
//   });
// }
