import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/screens/compound_route.dart';
import 'package:frontend/reservation/bloc/blocs/reservation_bloc.dart';
import 'package:frontend/reservation/bloc/states/reservation_state.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../compounds/bloc/compound_state.dart';

class UserReservations extends StatelessWidget {
  const UserReservations({super.key});
  String formatDate(String date) {
    String formattedTime =
        DateFormat('hh:mm:ss a').format(DateTime.parse(date));
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('List of Compounds')),
        body: BlocBuilder<ReservationBloc, ReservationState>(
          builder: (_, state) {
            if (state is ReservationFailure) {
              return const Text('Could not Load reservations');
            }

            if (state is ReservationOperationSucess) {
              final reservations = state.reservations;

              return ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (_, idx) => Center(
                  child: ListTile(
                      title: Text(reservations.elementAt(idx).id.toString()),
                      subtitle: Text(
                          '${formatDate(reservations.elementAt(idx).startTime)} - ${formatDate(reservations.elementAt(idx).endTime)}')),
                ),
              );
            }

            return const CircularProgressIndicator();
          },
        ));
  }
}
