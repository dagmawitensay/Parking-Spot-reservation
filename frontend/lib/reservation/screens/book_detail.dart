import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/reservation/bloc/blocs/reservation_bloc.dart';
import 'package:frontend/reservation/bloc/events/reservation_event.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../bloc/states/reservation_state.dart';

class BookDetail extends StatefulWidget {
  final int compoundId;
  final String startTime;
  final String endTime;
  final int spotId;

  const BookDetail(
      {required this.compoundId,
      required this.startTime,
      required this.endTime,
      required this.spotId});

  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  final _formKey = GlobalKey<FormState>();
  String? _plateNo = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Booking details"),
            leading: BackButton(
                onPressed: () => {
                      (context).goNamed('parkingSpots', queryParameters: {
                        'compound_id': [widget.compoundId.toString()],
                        'date': [widget.startTime.toString()],
                        'startTime': [widget.startTime],
                        'endTime': [widget.endTime]
                      })
                    })),
        body: BlocBuilder<ReservationBloc, ReservationState>(
            builder: (context, state) {
          if (state is PriceCalculated) {
            DateTime dateTime = DateTime.parse(widget.startTime);
            DateTime dateTime2 = DateTime.parse(widget.endTime);

            String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
            String formattedTime = DateFormat('hh:mm:ss a').format(dateTime);
            String formattedDate2 = DateFormat('yyyy-MM-dd').format(dateTime2);
            String formattedTime2 = DateFormat('hh:mm:ss a').format(dateTime2);
            return Form(
                key: _formKey,
                child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(8),
                            child: Text('Booking Details',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14))),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Column(children: [
                            Container(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                    'Reservation Date $formattedDate - $formattedDate2')),
                            Text(
                                'Reservation Time $formattedTime - $formattedTime2')
                          ]),
                        ),
                        Container(
                            padding: const EdgeInsets.all(5),
                            child: Text('parking Spot Id: ${widget.spotId}')),
                        Container(
                            padding: const EdgeInsets.all(5),
                            child: Text('Price: ${state.price}')),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            'Enter your license plate number: ',
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                          child: TextFormField(
                              initialValue: '',
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Please enter your license plate number';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'License plate number'),
                              onSaved: (value) {
                                setState(
                                  () {
                                    _plateNo = value;
                                  },
                                );
                              }),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton.icon(
                                onPressed: () {
                                  final form = _formKey.currentState;
                                  if (form != null && form.validate()) {
                                    form.save();
                                    ReservationEvent event = ReserveSpot(
                                        startTime: widget.startTime,
                                        endTime: widget.endTime,
                                        spot_id: widget.spotId,
                                        plateNo: _plateNo!,
                                        price: state.price);
                                    BlocProvider.of<ReservationBloc>(context)
                                        .add(event);

                                    (context).goNamed('sucess');
                                  }
                                },
                                label: const Text("Reserve"),
                                icon: const Icon(Icons.car_rental)))
                      ],
                    )));
          }
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  child: Text('Something went wrong')),
              ElevatedButton(
                  onPressed: () {
                    (context).goNamed('userCompounList');
                  },
                  child: const Text('Go back'))
            ],
          ));
        }));
  }
}
