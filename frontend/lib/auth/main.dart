import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/auth/bloc/blocs/owner_signup_bloc.dart';
import 'package:frontend/auth/bloc/events/owner_signup_event.dart';
import 'package:frontend/auth/data_provider/user_data_provider.dart';
import 'package:frontend/auth/repository/auth_repository.dart';
import 'package:frontend/auth/screens/owner_signup.dart';
import 'package:frontend/auth/screens/signin.dart';
import 'package:frontend/auth/screens/spot_reserver_signup.dart';
import 'package:go_router/go_router.dart';

import '../compounds/bloc_observer.dart';

void main() {
  UserDataProvider dataProvider = UserDataProvider();
  final AuthRepository authRepository = AuthRepository(dataProvider);

  Bloc.observer = MyBlocObserver();

  runApp(AuthApp(authRepository: authRepository));
}

class AuthApp extends StatelessWidget {
  final AuthRepository authRepository;

  AuthApp({Key? key, required this.authRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: authRepository,
        child: BlocProvider(
            create: (context) =>
                CompoundOwnerSignupBloc(authRepository: authRepository)
                  ..add(const OwnerSignUpLoad()),
            child: MaterialApp.router(
              title: 'Compound App',
              routerDelegate: _router.routerDelegate,
              routeInformationParser: _router.routeInformationParser,
              routeInformationProvider: _router.routeInformationProvider,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
            )));
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
          path: '/',
          builder: (context, state) => const OwnerSignupPage(),
          routes: <GoRoute>[
            GoRoute(
                path: 'auth/owner/signup',
                builder: (context, state) {
                  return const OwnerSignupPage();
                }),
            GoRoute(
                path: 'auth/reserver/signup',
                builder: (context, state) {
                  return const SpotReserverSignupPage();
                }),
            GoRoute(
                path: 'auth/signin',
                builder: (context, state) {
                  return const LoginPage();
                })
          ])
    ],
  );
}
