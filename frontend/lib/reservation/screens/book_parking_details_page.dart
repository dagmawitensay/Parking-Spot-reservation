import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/reservation/bloc/reservation_bloc.dart';
import 'package:frontend/reservation/repository/reservation_repository.dart';
import 'package:go_router/go_router.dart';

import '../bloc/reservation_state.dart';

class BookingDetailsPage extends StatelessWidget {
  final DateTime startTime;
  final DateTime endTime;
  final ReservationRepository reservationRepository;

  const BookingDetailsPage({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.reservationRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReservationBloc>(
      create: (context) => ReservationBloc(reservationRepository),
      child: BlocConsumer<ReservationBloc, ReservationState>(
        listener: (context, state) {
          if (state is ReservationLoading) {
            // Show loading indicator or progress dialog if needed
          } else if (state is ReservationSuccess) {
            // Navigation to success page using go_router
            GoRouter.of(context).go('/success');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Booking Details'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Start Time: ${startTime.toString()}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'End Time: ${endTime.toString()}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final reservationBloc =
                          BlocProvider.of<ReservationBloc>(context);
                      reservationBloc
                          .add(CreateReservation(startTime, endTime));
                    },
                    child: const Text('Book Now'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
