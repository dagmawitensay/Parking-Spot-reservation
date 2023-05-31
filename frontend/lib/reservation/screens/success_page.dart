import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/reservation/bloc/reservation_bloc.dart';

import '../bloc/reservation_state.dart';

class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationBloc, ReservationState>(
      builder: (context, state) {
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
                        // Dispatch an event to indicate the success of the booking
                        BlocProvider.of<ReservationBloc>(context)
                            .add(BookingSuccessEvent());
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
              title: const Text('Booking Success'),
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
