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
import 'package:frontend/reservation/bloc/blocs/reservation_bloc.dart';
import 'package:frontend/reservation/bloc/events/reservation_event.dart';
import 'package:frontend/reservation/bloc/states/reservation_state.dart';
import 'package:frontend/reservation/data_provider/reservation_data_provider.dart';
import 'package:frontend/reservation/repository/reservation_repository.dart';
import 'package:frontend/reservation/screens/book_detail.dart';
import 'package:frontend/reservation/screens/compound_list_for_user.dart';
import 'package:frontend/reservation/screens/parking_spots.dart';
import 'package:frontend/reservation/screens/reservations.dart';
import 'package:frontend/reservation/screens/success_page.dart';
import 'package:frontend/reservation/screens/time_picker_page.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';
import '../compounds/bloc_observer.dart';
import 'auth/screens/owner_profile.dart';
import 'auth/screens/reserver_profile.dart';
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

class AuthApp extends StatelessWidget {
  final AuthRepository authRepository;
  final CompoundRepository compoundRepository;
  final ReservationRepository reservationRepository;

  AuthApp(
      {Key? key,
      required this.authRepository,
      required this.compoundRepository,
      required this.reservationRepository})
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
              BlocProvider(
                  create: (context) => ReservationBloc(
                      reservationRepository: reservationRepository)),
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
          builder: (context, state) => const CompoundList(),
          redirect: (context, state) {
            final state = context.read<AuthenticationBloc>().state;
            if (state is AuthenticationUnauthenticated) {
              return '/auth/signin';
            } else if (state is AuthenticationAuthenticated) {
              if (state.role == 'owner') {
                return '/';
              } else if (state.role == 'reserver') {
                return '/compoundListUser';
              }
            }
          }),
      GoRoute(
          name: 'startingPage',
          path: '/startingPage',
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
            final state = context.read<AuthenticationBloc>().state;
            if (state is AuthenticationUnauthenticated) {
              return '/auth/signin';
            } else if (state is AuthenticationAuthenticated) {
              if (state.role == 'owner') {
                return '/addUpdateCompound';
              } else if (state.role == 'reserver') {
                return '/auth/signin';
              }
            }
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
      GoRoute(
          name: "userCompounList",
          path: '/compoundListUser',
          builder: (context, state) => CompoundListForUser()),
      GoRoute(
          name: 'timerPage',
          path: '/reservationTime',
          builder: (context, state) {
            int compound_id = int.parse(state.queryParameters['compound_id']!);
            return DateTimePicker(compound_id: compound_id);
          }),
      GoRoute(
          name: 'parkingSpots',
          path: '/parkingSpots',
          builder: (context, state) {
            return ParkingSpots(
                compoundId: int.parse(state.queryParameters['compound_id']!),
                date: DateTime.parse(state.queryParameters['date']!),
                startTime: state.queryParameters['startTime']!,
                endTime: state.queryParameters['endTime']!);
          }),
      GoRoute(
          name: 'bookingDetails',
          path: '/bookingDetails',
          builder: (context, state) {
            return BookDetail(
              startTime: state.queryParameters['startTime']!,
              endTime: state.queryParameters['endTime']!,
              compoundId: int.parse(state.queryParameters['compound_id']!),
              spotId: int.parse(state.queryParameters['spot_id']!),
            );
          }),
      GoRoute(
          name: 'sucess',
          path: '/reservationSucesss',
          builder: (context, state) {
            return const BookingSuccessPage();
          }),
      GoRoute(
          name: 'ownerProfile',
          path: '/ownerProfile',
          builder: (context, state) {
            return OwnerProfilePage();
          },
          redirect: (context, state) {
            final state = context.read<AuthenticationBloc>().state;
            if (state is AuthenticationUnauthenticated) {
              return '/auth/signin';
            } else if (state is AuthenticationAuthenticated) {
              if (state.role == 'reserver') {
                return '/auth/signin';
              }
            }
          }),
      GoRoute(
          name: 'reserverProfile',
          path: '/reserverProfile',
          builder: (context, state) {
            return const ReserverProfilePage();
          },
          redirect: (context, state) {
            final state = context.read<AuthenticationBloc>().state;
            if (state is AuthenticationUnauthenticated) {
              return '/auth/signin';
            } else if (state is AuthenticationAuthenticated) {
              if (state.role == 'owner') {
                return '/auth/signin';
              }
            }
          }),
      GoRoute(
          name: 'reservations',
          path: '/reservations',
          builder: (context, state) {
            return UserReservations();
          })
    ],
  );
}
