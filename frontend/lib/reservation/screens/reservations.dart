import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/screens/compound_route.dart';
import 'package:frontend/reservation/bloc/blocs/reservation_bloc.dart';
import 'package:frontend/reservation/bloc/events/reservation_event.dart';
import 'package:frontend/reservation/bloc/states/reservation_state.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../compounds/bloc/compound_state.dart';

class UserReservations extends StatefulWidget {
  const UserReservations({Key? key}) : super(key: key);

  @override
  _UserReservationsState createState() => _UserReservationsState();
}

class _UserReservationsState extends State<UserReservations> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      (context).goNamed('userCompounList');
    } else if (index == 1) {
      (context).goNamed('reserverProfile');
    } else if (index == 2) {
      (context).goNamed('reservations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Reservations')),
      body: BlocBuilder<ReservationBloc, ReservationState>(
        builder: (_, state) {
          if (state is ReservationFailure) {
            return Text(state.errorMessage);
          }

          if (state is ReservationOperationSucess) {
            final reservations = state.reservations;
            if (reservations == []) {
              return Center(
                  child: Text(
                "No reservations found!",
              ));
            }
            return ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (_, idx) => Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                ReservationEvent event = ReservationDelete(
                                    reservations.elementAt(idx).id);
                                BlocProvider.of<ReservationBloc>(context)
                                    .add(event);
                                setState(() {
                                  reservations.removeAt(idx);
                                });
                              },
                            ),
                            title: Text(
                                'Pakring Spot Id: ${reservations.elementAt(idx).id.toString()}'),
                            subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Date: ${DateFormat('yMd').format(DateTime.parse(reservations.elementAt(idx).startTime))}'),
                                  Text(
                                      '${DateFormat('hh:mm:ss a').format(DateTime.parse(reservations.elementAt(idx).startTime))} - ${DateFormat('hh:mm:ss a').format(DateTime.parse(reservations.elementAt(idx).endTime))}')
                                ])),
                      ),
                    ));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_parking), label: 'Reservations')
        ],
      ),
    );
  }
}
