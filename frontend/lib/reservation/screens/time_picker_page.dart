import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/reservation/bloc/blocs/reservation_bloc.dart';
import 'package:frontend/reservation/bloc/events/reservation_event.dart';
import 'package:frontend/reservation/bloc/states/reservation_state.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  final int compound_id;
  const DateTimePicker({required this.compound_id});
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  double? _height;
  double? _width;

  String? _setTime, _setDate;

  String? _hour, _minute, _time;

  String? dateTime;
  String message = '';

  DateTime selectedDate = DateTime.now();

  TimeOfDay startTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay endTime = TimeOfDay(hour: 00, minute: 00);

  final TextEditingController? _dateController = TextEditingController();
  final TextEditingController? _startTimeController = TextEditingController();
  final TextEditingController? _endTimeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController!.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    print(picked);
    if (picked != null)
      setState(() {
        startTime = picked;
        _hour = startTime.hour.toString();
        _minute = startTime.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        _startTimeController!.text = _time!;
        _startTimeController!.text = formatDate(
            DateTime(2019, 08, 1, startTime.hour, startTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  Future<Null> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (picked != null)
      setState(() {
        endTime = picked;
        print(picked);
        _hour = endTime.hour.toString();
        _minute = endTime.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        _endTimeController!.text = _time!;
        _endTimeController!.text = formatDate(
            DateTime(2019, 08, 1, endTime.hour, endTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  String formatDateTime(DateTime inputDate, TimeOfDay inputTime) {
    final parsedDate = inputDate;
    final formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      inputTime.hour,
      inputTime.minute,
    );

    final formattedTime = DateFormat('HH:mm:ss').format(dateTime);

    return '$formattedDate $formattedTime';
  }

  @override
  void initState() {
    _dateController!.text = DateFormat.yMd().format(DateTime.now());

    _startTimeController!.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    _endTimeController!.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Pick Reservation Time'),
          leading: BackButton(
              onPressed: () => (context).goNamed('userCompounList'))),
      body: Container(
        width: _width,
        height: _height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Choose Date',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    width: _width! / 1.7,
                    height: _height! / 9,
                    margin: EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dateController,
                      onSaved: (String? val) {
                        _setDate = val;
                      },
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.only(top: 0.0)),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Choose Start Time',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectStartTime(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    width: _width! / 1.7,
                    height: _height! / 9,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      onSaved: (String? val) {
                        _setTime = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _startTimeController,
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Choose End Time',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectEndTime(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    width: _width! / 1.7,
                    height: _height! / 9,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      onSaved: (String? val) {
                        _setTime = val;
                      },
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _endTimeController,
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(30),
                    child: Center(child: Text(message))),
                Container(
                    padding: const EdgeInsets.all(30),
                    child: Center(
                        child: ElevatedButton(
                      child: Text('Next'),
                      onPressed: () {
                        DateTime time1 = DateTime.parse(
                            formatDateTime(selectedDate, startTime));
                        DateTime time2 = DateTime.parse(
                            formatDateTime(selectedDate, endTime));

                        if ((TimeOfDay(hour: 00, minute: 00) == startTime &&
                                TimeOfDay(hour: 00, minute: 00) == endTime) ||
                            time2.isBefore(time1)) {
                          setState(() {
                            message = "Please select correct time";
                          });
                        } else {
                          ReservationEvent event = ParkingSpotLoad(
                              widget.compound_id,
                              selectedDate,
                              formatDateTime(selectedDate, startTime),
                              formatDateTime(selectedDate, startTime));
                          BlocProvider.of<ReservationBloc>(context).add(event);
                          (context).goNamed('parkingSpots', queryParameters: {
                            'compound_id': [widget.compound_id.toString()],
                            'date': [selectedDate.toString()],
                            'startTime': [
                              formatDateTime(selectedDate, startTime)
                            ],
                            'endTime': [formatDateTime(selectedDate, endTime)]
                          });
                        }
                      },
                    )))
              ],
            )
          ],
        ),
      ),
    );
  }
}
