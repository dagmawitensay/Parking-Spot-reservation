import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/reservation/bloc/compound_bloc.dart';
import 'package:frontend/reservation/bloc/parking_spot_bloc.dart';
import 'package:frontend/reservation/bloc/reservation_bloc.dart';
import 'package:frontend/reservation/bloc/time_picker_bloc.dart';
import 'package:frontend/reservation/data_provider/parking_compound_data_provider.dart';
import 'package:frontend/reservation/data_provider/parking_spot_data_provider.dart';
import 'package:frontend/reservation/data_provider/reservation_data_provider.dart';
import 'package:frontend/reservation/models/parking_spot.dart';
import 'package:frontend/reservation/repository/parking_spot_repository.dart';
import 'package:frontend/reservation/repository/reservation_repository.dart';
import 'package:frontend/reservation/screens/book_parking_details_page.dart';
import 'package:frontend/reservation/screens/compound_listing_page.dart';
import 'package:frontend/reservation/screens/pick_parking_spot_page.dart';
import 'package:frontend/reservation/screens/success_page.dart';
import 'package:frontend/reservation/screens/time_picker_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ParkingCompoundBloc>(
          create: (_) => ParkingCompoundBloc(ParkingCompoundDataProvider()),
        ),
        BlocProvider<ParkingSpotBloc>(
          create: (_) => ParkingSpotBloc(
            parkingSpotRepository: ParkingSpotRepository(
              parkingSpotDataProvider: ParkingSpotDataProvider(),
            ),
          ),
        ),
        BlocProvider<TimePickerBloc>(
          create: (_) => TimePickerBloc(),
        ),
        BlocProvider<ReservationBloc>(
          create: (_) => ReservationBloc(
            ReservationRepository(ReservationDataProvider()),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Park System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => const CompoundListingPage(),
          '/park-spot/:compoundId': (context) {
            final compoundId =
                ModalRoute.of(context)!.settings.arguments as String;
            return ParkSpotPage(compoundId: compoundId);
          },
          '/time-picker': (BuildContext context) {
            final queryParams = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;
            final parkingSpotId = queryParams['parkingSpot'] as String;
            final compoundId = queryParams['compoundId'] as String;
            final parkingSpot = ParkingSpot(
              id: int.parse(parkingSpotId),
              compoundId: int.parse(compoundId),
            );
            return TimePickerPage(parkingSpot: parkingSpot);
          },
          '/booking-details': (context) {
            final args = ModalRoute.of(context)!.settings.arguments
                as Map<String, String>;
            final startTime = DateTime.parse(args['startTime']!);
            final endTime = DateTime.parse(args['endTime']!);
            return BookingDetailsPage(
              startTime: startTime,
              endTime: endTime,
              reservationRepository: ReservationRepository(
                ReservationDataProvider(),
              ),
            );
          },
          '/success': (context) => const BookingSuccessPage(),
        },
      ),
    );
  }
}
