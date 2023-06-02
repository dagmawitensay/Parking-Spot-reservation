import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/blocs/reservation_bloc.dart';
import '../bloc/states/reservation_state.dart';

class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationBloc, ReservationState>(
      builder: (context, state) {
        print(state);
        if (state is ReservationFailure) {
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  child: Text('Reservation was unsuceesful!')),
              ElevatedButton(
                  onPressed: () {
                    (context).goNamed('home');
                  },
                  child: const Text('Go back'))
            ],
          ));
        }
        if (state is ReservationSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Booking Success'),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 80,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Your booking was successful!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        (context).goNamed('userCompounList');
                      },
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Making the reservation!'),
            ),
            body: const Center(
              child:
                  CircularProgressIndicator(), // Show loading indicator while waiting for the success state
            ),
          );
        }
      },
    );
  }
}
