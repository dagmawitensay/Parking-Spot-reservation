import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/reservation/bloc/blocs/reservation_bloc.dart';
import 'package:frontend/reservation/bloc/events/reservation_event.dart';
import 'package:go_router/go_router.dart';

import '../bloc/states/reservation_state.dart';

class ParkingSpots extends StatefulWidget {
  final int compoundId;
  final DateTime date;
  final String startTime;
  final String endTime;
  const ParkingSpots(
      {required this.compoundId,
      required this.date,
      required this.startTime,
      required this.endTime});

  _ParkingSpotsState createState() => _ParkingSpotsState();
}

class _ParkingSpotsState extends State<ParkingSpots> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Parking Spots'),
            leading: BackButton(
                onPressed: () =>
                    (context).goNamed('timerPage', queryParameters: {
                      'compound_id': [widget.compoundId.toString()]
                    }))),
        body: BlocBuilder<ReservationBloc, ReservationState>(
            builder: (context, state) {
          print(state);
          if (state is ParkingSpotFailure) {
            return const Text('Could not load parking Spots');
          }

          if (state is ParkingSpotsSucess) {
            final parkingSpotsData = state.parkingSpotsData;
            print("her on parking spots page");
            print(parkingSpotsData);
            final availableSpots = parkingSpotsData[0];
            final totalSpots = parkingSpotsData[1];
            var isavaialable = true;
            var status = '';

            Map<int, List> resultMap = {};
            for (int i = 0; i < totalSpots.length; i++) {
              int element = totalSpots[i];
              bool isSubset = availableSpots.contains(element);

              resultMap[i] = [element, isSubset];
            }
            print(resultMap);
            if (availableSpots.length == 0) {
              return Container(
                padding: const EdgeInsets.all(40),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                              "No availabe spots found form time ${widget.startTime} - ${widget.endTime} in this compound.")),
                      ElevatedButton(
                          onPressed: () {
                            (context).goNamed('userCompounList');
                          },
                          child: const Text('Go back to componds'))
                    ]),
              );
            }

            return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: totalSpots.length,
                itemBuilder: (BuildContext ctx, index) {
                  status = resultMap[index]![1] ? 'Available' : 'Unavailable';
                  return GestureDetector(
                      onTap: () {
                        if (resultMap[index]![1]) {
                          print(widget.startTime);
                          print(widget.endTime);
                          print(widget.compoundId);
                          print(widget.date);
                          ReservationEvent event = PriceCalculation(
                            startTime: widget.startTime,
                            endTime: widget.endTime,
                            compoundId: widget.compoundId,
                          );
                          BlocProvider.of<ReservationBloc>(context).add(event);
                          (context).goNamed('bookingDetails', queryParameters: {
                            'compound_id': [widget.compoundId.toString()],
                            'spot_id': [resultMap[index]![0].toString()],
                            'startTime': [widget.startTime],
                            'endTime': [widget.endTime],
                          });
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                'Parking Spot Id: ${resultMap[index]![0].toString()}'),
                            Text('Status: $status')
                          ],
                        ),
                      ));
                });
          }
          return const Center(child: CircularProgressIndicator());
        }));
  }
}