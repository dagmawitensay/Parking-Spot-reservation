// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:frontend/auth/bloc/blocs/owner_signup_bloc.dart';
// import 'package:frontend/auth/bloc/events/owner_signup_event.dart';
// import 'package:frontend/auth/bloc/states/owner_signup_state.dart';
// import 'package:frontend/auth/models/auth.dart';
// import 'package:frontend/auth/screens/owner_signup.dart';
// import 'package:frontend/auth/repository/auth_repository.dart';
// import 'package:frontend/auth/data_provider/user_data_provider.dart';
// import 'package:frontend/auth/bloc/events/owner_signup_event.dart';
// // import 'package:frontend/auth/bloc/states/owner_signup_state.dart';


// class MockOwnerDataProvider extends UserDataProvider {
//   final CompoundOwner owner;

//   MockOwnerDataProvider(this.owner);

//   @override
//   Future<CompoundOwner> signUpCompoundOwner(CompoundOwner owner) async {
//     // Mock the API call to simulate a successful sign-up
//     return Future.delayed(Duration(milliseconds: 500), () => this.owner);
//   }
// }


// void main() {
//   final owner = CompoundOwner(
//   username: 'testuser',
//   email: 'testuser@example.com',
//   password: 'password',
//   firstName: 'John',
//   lastName: 'Doe',
// );
//   group('OwnerSignupPage', () {
//     late CompoundOwnerSignupBloc ownerSignupBloc;
//     late AuthRepository authRepository;

//    setUp(() {
//   authRepository = AuthRepository(MockOwnerDataProvider(owner));
//   ownerSignupBloc = CompoundOwnerSignupBloc(authRepository: authRepository);
// });


//     tearDown(() {
//       ownerSignupBloc.close();
//     });

//     testWidgets('Renders form when not loading', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         BlocProvider<CompoundOwnerSignupBloc>.value(
//           value: ownerSignupBloc,
//           child: MaterialApp(
//             home: OwnerSignupPage(),
//           ),
//         ),
//       );

//       expect(find.byType(TextFormField), findsNWidgets(6));
//       expect(find.byType(ElevatedButton), findsOneWidget);
//     });

//     testWidgets('Renders loading indicator when loading',
//         (WidgetTester tester) async {
//       ownerSignupBloc.add(OwnerSignUpLoad());

//       await tester.pumpWidget(
//         BlocProvider<CompoundOwnerSignupBloc>.value(
//           value: ownerSignupBloc,
//           child: MaterialApp(
//             home: OwnerSignupPage(),
//           ),
//         ),
//       );

//       expect(find.byType(CircularProgressIndicator), findsOneWidget);
//     });

//     testWidgets('Renders success message when sign up is successful',
//         (WidgetTester tester) async {
//       ownerSignupBloc.add(OwnerSignUp(owner: owner));

//       await tester.pumpWidget(
//         BlocProvider<CompoundOwnerSignupBloc>.value(
//           value: ownerSignupBloc,
//           child: MaterialApp(
//             home: OwnerSignupPage(),
//           ),
//         ));
//         expect(find.text('Sign Up successful'), findsOneWidget);
//   });

      
  

//     testWidgets('Renders error message when sign up fails',
//         (WidgetTester tester) async {
//       const errorMessage = 'Sign up failed';
//       ownerSignupBloc.add(OwnerSignUp(owner: owner));

//       await tester.pumpWidget(
//         BlocProvider<CompoundOwnerSignupBloc>.value(
//           value: ownerSignupBloc,
//           child: MaterialApp(
//             home: OwnerSignupPage(),
//           ),
//         ),
//       );

//       expect(find.text(errorMessage), findsOneWidget);
// });

//     testWidgets('Submits the form and triggers sign up',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(
//         BlocProvider<CompoundOwnerSignupBloc>.value(
//           value: ownerSignupBloc,
//           child: MaterialApp(
//             home: OwnerSignupPage(),
//           ),
//         ),
//       );

//       final firstNameField = find.byKey(const Key('firstNameField'));
//       final lastNameField = find.byKey(const Key('lastNameField'));
//       final usernameField = find.byKey(const Key('usernameField'));
//       final emailField = find.byKey(const Key('emailField'));
//       final passwordField = find.byKey(const Key('passwordField'));
//       final signUpButton = find.text('Sign Up');

//       expect(firstNameField, findsOneWidget);
//       expect(lastNameField, findsOneWidget);
//       expect(usernameField, findsOneWidget);
//       expect(emailField, findsOneWidget);
//       expect(passwordField, findsOneWidget);
//       expect(signUpButton, findsOneWidget);

//       await tester.enterText(firstNameField, 'John');
//       await tester.enterText(lastNameField, 'Doe');
//       await tester.enterText(usernameField, 'johndoe');
//       await tester.enterText(emailField, 'johndoe@example.com');
//       await tester.enterText(passwordField, 'password');

//       await tester.tap(signUpButton);
//       await tester.pumpAndSettle();

//       // Assert that the sign-up event was triggered with the correct data
//       // final ownerSignUpEvent = ownerSignupBloc.state;
//       // expect(ownerSignUpEvent, isA<OwnerSignUpLoading>());
//       // await tester.pump(Duration(milliseconds: 500));

//       // // Assert that the loading state is updated
//       // expect(ownerSignupBloc.state, isA<OwnerSignUpSuccess>());
//       // await tester.pump(Duration(milliseconds: 500));

//       // // Assert that the success state is rendered
//       // expect(find.text('Sign Up successful'), findsOneWidget);
//     });
//   });
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/auth/bloc/blocs/owner_signup_bloc.dart';
import 'package:frontend/auth/bloc/events/owner_signup_event.dart';
import 'package:frontend/auth/bloc/states/owner_signup_state.dart';
import 'package:frontend/auth/models/auth.dart';
import 'package:frontend/auth/screens/owner_signup.dart';
import 'package:frontend/auth/repository/auth_repository.dart';
import 'package:frontend/auth/data_provider/user_data_provider.dart';

class MockOwnerDataProvider extends UserDataProvider {
  final CompoundOwner owner;

  MockOwnerDataProvider(this.owner);

  @override
  Future<CompoundOwner> signUpCompoundOwner(CompoundOwner owner) async {
    // Mock the API call to simulate a successful sign-up
    return Future.delayed(Duration(milliseconds: 500), () => this.owner);
  }
}

void main() {
  final owner = CompoundOwner(
    username: 'testuser',
    email: 'testuser@example.com',
    password: 'password',
    firstName: 'John',
    lastName: 'Doe',
  );

  group('OwnerSignupPage', () {
    late CompoundOwnerSignupBloc ownerSignupBloc;
    late AuthRepository authRepository;

    setUp(() {
      authRepository = AuthRepository(MockOwnerDataProvider(owner));
      ownerSignupBloc = CompoundOwnerSignupBloc(authRepository: authRepository);
    });

    tearDown(() {
      ownerSignupBloc.close();
    });

    testWidgets('Renders form when not loading', (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<CompoundOwnerSignupBloc>.value(
          value: ownerSignupBloc,
          child: MaterialApp(
            home: OwnerSignupPage(),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsNWidgets(6));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Renders loading indicator when loading',
        (WidgetTester tester) async {
      ownerSignupBloc.add(OwnerSignUpLoad());

      await tester.pumpWidget(
        BlocProvider<CompoundOwnerSignupBloc>.value(
          value: ownerSignupBloc,
          child: MaterialApp(
            home: OwnerSignupPage(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Renders success message when sign up is successful',
        (WidgetTester tester) async {
      ownerSignupBloc.add(OwnerSignUp(owner: owner));

      await tester.pumpWidget(
        BlocProvider<CompoundOwnerSignupBloc>.value(
          value: ownerSignupBloc,
          child: MaterialApp(
            home: OwnerSignupPage(),
          ),
        ),
      );

      expect(find.text('Sign Up successful'), findsOneWidget);
    });

    testWidgets('Renders error message when sign up fails',
        (WidgetTester tester) async {
      const errorMessage = 'Sign up failed';
      ownerSignupBloc.add(OwnerSignUp(owner: owner));

      await tester.pumpWidget(
        BlocProvider<CompoundOwnerSignupBloc>.value(
          value: ownerSignupBloc,
          child: MaterialApp(
            home: OwnerSignupPage(),
          ),
        ),
      );

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('Submits the form and triggers sign up',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<CompoundOwnerSignupBloc>.value(
          value: ownerSignupBloc,
          child: MaterialApp(
            home: OwnerSignupPage(),
          ),
        ),
      );

      final firstNameField = find.byKey(const Key('firstNameField'));
      final lastNameField = find.byKey(const Key('lastNameField'));
      final usernameField = find.byKey(const Key('usernameField'));
      final emailField = find.byKey(const Key('emailField'));
      final passwordField = find.byKey(const Key('passwordField'));
      final signUpButton = find.text('Sign Up');

      expect(firstNameField, findsOneWidget);
      expect(lastNameField, findsOneWidget);
      expect(usernameField, findsOneWidget);
      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(signUpButton, findsOneWidget);

      await tester.enterText(firstNameField, 'John');
      await tester.enterText(lastNameField, 'Doe');
      await tester.enterText(usernameField, 'johndoe');
      await tester.enterText(emailField, 'johndoe@example.com');
      await tester.enterText(passwordField, 'password');

      await tester.tap(signUpButton);
      await tester.pumpAndSettle();

      // Assert that the sign-up event was triggered with the correct data
      final ownerSignUpEvent = ownerSignupBloc.state;
      expect(ownerSignUpEvent, isA<OwnerSignUpLoading>());
      await tester.pump(Duration(milliseconds: 500));

      // Assert that the loading state is updated
      expect(ownerSignupBloc.state, isA<OwnerSignUpSuccess>());
      await tester.pump(Duration(milliseconds: 500));

      // Assert that the success state is rendered
      expect(find.text('Sign Up successful'), findsOneWidget);
    });
  });
}
