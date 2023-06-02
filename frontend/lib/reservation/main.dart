import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/bloc/compound_event.dart';
import 'package:frontend/compounds/data_provider/compound_data_provider.dart';
import 'package:frontend/compounds/data_provider/compound_local_data_provider.dart';
import 'package:frontend/compounds/repository/compound_repository.dart';
import 'package:frontend/localDatabase/connectivity_checking.dart';
import 'package:frontend/reservation/bloc/blocs/reservation_bloc.dart';
import 'package:frontend/reservation/data_provider/reservation_data_provider.dart';
import 'package:frontend/reservation/repository/reservation_repository.dart';
import 'package:frontend/reservation/screens/book_detail.dart';
import 'package:frontend/reservation/screens/compound_list_for_user.dart';
import 'package:frontend/reservation/screens/parking_spots.dart';
import 'package:frontend/reservation/screens/routes.dart';
import 'package:frontend/reservation/screens/success_page.dart';
import 'package:frontend/reservation/screens/time_picker_page.dart';
import 'package:go_router/go_router.dart';

void main() {
  final CompoundRepository compoundRepository = CompoundRepository(
      CompoundDataProvider(),
      CompoundLocalDataProvider(),
      ConnectivityChecks());
  final ReservationRepository reservationRepository =
      ReservationRepository(ReservationDataProvider());
  runApp(MyApp(
    compoundRepository: compoundRepository,
    reservationRepository: reservationRepository,
  ));
}

class MyApp extends StatelessWidget {
  final CompoundRepository compoundRepository;
  final ReservationRepository reservationRepository;
  const MyApp(
      {required this.compoundRepository, required this.reservationRepository});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: compoundRepository,
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    CompoundBloc(compoundRepository: compoundRepository)
                      ..add(const CompoundLoad())),
            BlocProvider(
              create: (context) =>
                  ReservationBloc(reservationRepository: reservationRepository),
            ),
          ],
          child: MaterialApp.router(
            title: 'Course App',
            routerConfig: _router,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
          )),
    );
  }
}

final _router = GoRouter(routes: [
  GoRoute(
    name: "userCompounList",
    path: '/',
    builder: (context, state) => CompoundListForUser(),
  ),
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
      name: 'details',
      path: '/details',
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
      })
]);
