import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/screens/compound_route.dart';
import 'package:frontend/reservation/bloc/blocs/reservation_bloc.dart';
import 'package:frontend/reservation/bloc/events/reservation_event.dart';
import 'package:go_router/go_router.dart';

import '../../compounds/bloc/compound_state.dart';

class CompoundListForUser extends StatefulWidget {
  const CompoundListForUser({Key? key}) : super(key: key);

  @override
  _CompoundListForUserState createState() => _CompoundListForUserState();
}

class _CompoundListForUserState extends State<CompoundListForUser> {
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
      ReservationEvent event = ReservationLoad();
      BlocProvider.of<ReservationBloc>(context).add(event);
      (context).goNamed('reservations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Compounds'),
      ),
      body: BlocBuilder<CompoundBloc, CompoundState>(
        builder: (_, state) {
          if (state is CompoundOperationFailure) {
            return const Text('Could not do compound operation');
          }

          if (state is CompoundOperationSuccess) {
            final compounds = state.compounds;

            return GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 500,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: compounds.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                      onTap: () {
                        (context).goNamed('timerPage', queryParameters: {
                          'compound_id': [
                            compounds.elementAt(index).id.toString()
                          ]
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.brown[100],
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(10),
                                child: Text(compounds.elementAt(index).name)),
                            Container(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Spot Price Per Hour: "),
                                      Text(compounds
                                          .elementAt(index)
                                          .SlotPricePerHour
                                          .toString())
                                    ]))
                          ],
                        ),
                      ));
                });
          }

          return const CircularProgressIndicator();
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
