import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/reservation/bloc/time_picker_bloc.dart';
import 'package:frontend/reservation/bloc/time_picker_event.dart';
import 'package:frontend/reservation/bloc/time_picker_state.dart';
import 'package:frontend/reservation/models/parking_spot.dart';
import 'package:go_router/go_router.dart';

class TimePickerPage extends StatelessWidget {
  final ParkingSpot parkingSpot;

  const TimePickerPage({Key? key, required this.parkingSpot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Picker'),
      ),
      body: BlocBuilder<TimePickerBloc, TimePickerState>(
        builder: (context, state) {
          final timePickerBloc = BlocProvider.of<TimePickerBloc>(context);
          final startTime =
              (state is StartTimeSelected) ? state.startTime : null;
          final endTime = (state is EndTimeSelected) ? state.endTime : null;
          final isNextButtonEnabled = startTime != null && endTime != null;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Selected Start Time: ${startTime ?? ''}',
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Selected End Time: ${endTime ?? ''}',
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    timePickerBloc.add(SelectStartTime());
                  },
                  child: const Text('Select Start Time'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    timePickerBloc.add(SelectEndTime());
                  },
                  child: const Text('Select End Time'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: isNextButtonEnabled
                      ? () {
                          final parameters = {
                            'startTime': startTime.toString(),
                            'endTime': endTime.toString(),
                            'parkingSpot': parkingSpot.toString(),
                          };

                          final queryString =
                              Uri(queryParameters: parameters).query;
                          final url = '/booking_details?$queryString';
                          GoRouter.of(context).go(url);
                        }
                      : null,
                  child: const Text('Next'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
