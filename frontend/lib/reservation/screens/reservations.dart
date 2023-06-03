import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/screens/compound_route.dart';
import 'package:frontend/reservation/bloc/blocs/reservation_bloc.dart';
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
      (context).goNamed('profile');
    } else if (index == 2) {
      (context).goNamed('reservations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Reservations')),
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
                        '${DateFormat('hh:mm:ss a').format(DateTime.parse(reservations.elementAt(idx).startTime))} - ${DateFormat('hh:mm:ss a').format(DateTime.parse(reservations.elementAt(idx).endTime))}')),
              ),
            );
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
