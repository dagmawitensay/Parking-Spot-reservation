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
import '../compounds/bloc_observer.dart';
import 'compounds/bloc/compound_bloc.dart';
import 'compounds/bloc/compound_event.dart';
import 'compounds/data_provider/compound_data_provider.dart';
import 'compounds/repository/compound_repository.dart';
import 'compounds/screens/compound_add_update.dart';
import 'compounds/screens/compound_detail.dart';
import 'compounds/screens/compound_route.dart';
import 'compounds/screens/home_page.dart';
import 'compounds/data_provider/compound_local_data_provider.dart';
import 'localDatabase/connectivity_checking.dart';
import 'sync_manager/syncing.dart';



void main() {
  UserDataProvider userdataProvider = UserDataProvider();
  CompoundDataProvider compoundDataProvider = CompoundDataProvider();
   SyncManager      syncManager = SyncManager();
  CompoundLocalDataProvider localProvider = CompoundLocalDataProvider();
  ConnectivityChecks  connectivitychecker = ConnectivityChecks();

  final AuthRepository authRepository = AuthRepository(userdataProvider);
  final CompoundRepository compoundRepository =
      CompoundRepository(compoundDataProvider, localProvider,connectivitychecker);
  syncManager.syncingManager();
  Bloc.observer = MyBlocObserver();
  setPathUrlStrategy();

  runApp(AuthApp(
      authRepository: authRepository, compoundRepository: compoundRepository));
}

class AuthApp extends StatelessWidget {
  final AuthRepository authRepository;
  final CompoundRepository compoundRepository;


  AuthApp(
      {Key? key,
      required this.authRepository,
      required this.compoundRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: authRepository,
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) =>
                      AuthenticationBloc(authRepository: authRepository)
                        ..add(AppStarted())),
              BlocProvider(
                create: (context) => SignInBloc(authRepository: authRepository)
                  ..add(const SignInFormInitalizedEvent()),
              ),
              BlocProvider(
                create: (context) =>
                    CompoundOwnerSignupBloc(authRepository: authRepository),
              ),
              BlocProvider(
                create: (context) =>
                    ReserverSignupBloc(authRepository: authRepository),
              ),
              BlocProvider(
                  create: (context) =>
                      CompoundBloc(compoundRepository: compoundRepository)
                        ..add(const CompoundLoad())),
            ],
            child: MaterialApp.router(
                title: 'Compound App',
                routerConfig: _router,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ))));
    // child: MaterialApp(home: const LoginPage())));
  }

  final _router = GoRouter(
    routes: [
      GoRoute(
          name: "home",
          path: '/',
          builder: (context, state) => CompoundList(),
          redirect: (context, state) {
            if (state is AuthenticationUnauthenticated) {
              print('user is authenticated');
              return '/startingPage';
            }
            return '/';
          }),
      GoRoute(
          name: 'startingPage',
          path: '/home',
          builder: (context, state) => HomePage()),
      GoRoute(
          name: 'ownerSignup',
          path: '/auth/owner/signup',
          builder: (context, state) {
            return const OwnerSignupPage();
          }),
      GoRoute(
          name: 'reserverSignup',
          path: '/auth/reserver/signup',
          builder: (context, state) {
            return const SpotReserverSignupPage();
          }),

      GoRoute(
          name: 'signin',
          path: '/auth/signin',
          builder: (context, state) {
            return const LoginPage();
          }),
      GoRoute(
          name: 'addUpdate',
          path: '/addUpdateCompound',
          builder: (context, state) {
            CompoundArgument args = state.extra as CompoundArgument;
            return AddUpdateCompound(args: args);
          },
          redirect: (context, state) {
            if (state is CompoundOperationFailure) {
              return '/auth/signin';
            }
            return '/addUpdateCompound';
          }),
      GoRoute(
          name: 'compoundList',
          path: '/compoundList',
          builder: (context, state) {
            return CompoundList();
          }),
      GoRoute(
          name: 'details',
          path: '/details',
          builder: (context, state) {
            CompoundArgument args = state.extra as CompoundArgument;
            return CompoundDetail(compound: args.compound!);
          }),
      // GoRoute(
      //   path: '/compounds/:id',
      //   pageBuilder: (context, state) => CompoundDetailsPage(compoundId: state.params['id']),
      // ),
      // GoRoute(
      //   path: '/compounds/add',
      //   pageBuilder: (context, state) => CompoundAddUpdatePage(),
      //   authGuard: CompoundOwnerAuthGuard(), // Implement appropriate auth guard for compound owners.
      // ),
      // GoRoute(
      //   path: '/compounds/:id/update',
      //   pageBuilder: (context, state) => CompoundAddUpdatePage(compoundId: state.params['id']),
      //   authGuard: CompoundOwnerAuthGuard(), // Implement appropriate auth guard for compound owners.
      // ),
      // GoRoute(
      //   path: '/reservations',
      //   pageBuilder: (context, state) => ReservationPage(),
      //   authGuard: SpotUserAuthGuard(), // Implement appropriate auth guard for spot users.
      // ),
    ],
  );
}
// void main() {
//   UserDataProvider userdataProvider = UserDataProvider();
//   CompoundDataProvider compoundDataProvider = CompoundDataProvider();

//   final AuthRepository authRepository = AuthRepository(userdataProvider);
//   final CompoundRepository compoundRepository =
//       CompoundRepository(compoundDataProvider);

//   Bloc.observer = MyBlocObserver();

//   runApp(AuthApp(
//     authRepository: authRepository,
//     compoundRepository: compoundRepository,
//   ));
// }

// class AuthApp extends StatelessWidget {
//   final AuthRepository authRepository;
//   final CompoundRepository compoundRepository;

//   AuthApp(
//       {Key? key,
//       required this.authRepository,
//       required this.compoundRepository})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider.value(
//         value: authRepository,
//         child: MultiBlocProvider(
//             providers: [
//               BlocProvider<CompoundOwnerSignupBloc>(
//                 create: (context) =>
//                     CompoundOwnerSignupBloc(authRepository: authRepository)
//                       ..add(const OwnerSignUpFormInitalizedEvent()),
//                 // child: MaterialApp(title: 'auth', home: const OwnerSignupPage())
//               ),
//               BlocProvider<SignInBloc>(
//                   create: (context) =>
//                       SignInBloc(authRepository: authRepository)
//                         ..add(const SignInFormInitalizedEvent())),
//               BlocProvider<CompoundBloc>(
//                   create: (context) =>
//                       CompoundBloc(compoundRepository: compoundRepository)
//                         ..add(const CompoundLoad()))
//             ],
//             child: MaterialApp.router(
//               title: 'Compound App',
//               routerDelegate: _router.routerDelegate,
//               routeInformationParser: _router.routeInformationParser,
//               routeInformationProvider: _router.routeInformationProvider,
//               theme: ThemeData(
//                 primarySwatch: Colors.blue,
//                 visualDensity: VisualDensity.adaptivePlatformDensity,
//               ),
//             )));
//   }
