import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// BLoC
enum DateTimeSelectionType {
  Date,
  StartTime,
  EndTime,
}

abstract class DateTimeSelectionEvent {}

class DateTimeSelectedEvent extends DateTimeSelectionEvent {
  final DateTime dateTime;
  final DateTimeSelectionType selectionType;

  DateTimeSelectedEvent(this.dateTime, this.selectionType);
}

abstract class DateTimeSelectionState {}

class InitialState extends DateTimeSelectionState {}

class DateTimeSelectedState extends DateTimeSelectionState {
  final DateTime dateTime;
  final DateTimeSelectionType selectionType;

  DateTimeSelectedState(this.dateTime, this.selectionType);
}

class DateTimeSelectionBloc
    extends Bloc<DateTimeSelectionEvent, DateTimeSelectionState> {
  DateTimeSelectionBloc() : super(InitialState());

  @override
  Stream<DateTimeSelectionState> mapEventToState(
      DateTimeSelectionEvent event) async* {
    if (event is DateTimeSelectedEvent) {
      yield DateTimeSelectedState(event.dateTime, event.selectionType);
    }
  }
}

// App
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Time Picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => DateTimeSelectionBloc(),
        child: TimePickerPage(),
      ),
    );
  }
}

class TimePickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dateTimeSelectionBloc =
        BlocProvider.of<DateTimeSelectionBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Picker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _showDatePicker(context, dateTimeSelectionBloc);
              },
              child: Text('Select Date'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _showTimePicker(context, DateTimeSelectionType.StartTime,
                    dateTimeSelectionBloc);
              },
              child: Text('Select Start Time'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _showTimePicker(context, DateTimeSelectionType.EndTime,
                    dateTimeSelectionBloc);
              },
              child: Text('Select End Time'),
            ),
            const SizedBox(height: 32.0),
            BlocBuilder<DateTimeSelectionBloc, DateTimeSelectionState>(
              builder: (context, state) {
                final selectedDate = (state is DateTimeSelectedState &&
                        state.selectionType == DateTimeSelectionType.Date)
                    ? state.dateTime
                    : null;

                final selectedStartTime = (state is DateTimeSelectedState &&
                        state.selectionType == DateTimeSelectionType.StartTime)
                    ? state.dateTime
                    : null;

                final selectedEndTime = (state is DateTimeSelectedState &&
                        state.selectionType == DateTimeSelectionType.EndTime)
                    ? state.dateTime
                    : null;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Selected Date: ${selectedDate ?? ''}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Selected Start Time: ${selectedStartTime ?? ''}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Selected End Time: ${selectedEndTime ?? ''}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                );
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Continue reservation logic
              },
              child: Text('Continue Reservation'),
            ),
          ],
        ),
      ),
    );
  }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// BLoC
enum DateTimeSelectionType {
  Date,
  StartTime,
  EndTime,
}

abstract class DateTimeSelectionEvent {}

class DateTimeSelectedEvent extends DateTimeSelectionEvent {
  final DateTime dateTime;
  final DateTimeSelectionType selectionType;

  DateTimeSelectedEvent(this.dateTime, this.selectionType);
}

abstract class DateTimeSelectionState {}

class InitialState extends DateTimeSelectionState {}

class DateTimeSelectedState extends DateTimeSelectionState {
  final DateTime dateTime;
  final DateTimeSelectionType selectionType;

  DateTimeSelectedState(this.dateTime, this.selectionType);
}

class DateTimeSelectionBloc
    extends Bloc<DateTimeSelectionEvent, DateTimeSelectionState> {
  DateTimeSelectionBloc() : super(InitialState());

  @override
  Stream<DateTimeSelectionState> mapEventToState(
      DateTimeSelectionEvent event) async* {
    if (event is DateTimeSelectedEvent) {
      yield DateTimeSelectedState(event.dateTime, event.selectionType);
    }
  }
}

// App
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Time Picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => DateTimeSelectionBloc(),
        child: TimePickerPage(),
      ),
    );
  }
}

class TimePickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dateTimeSelectionBloc =
        BlocProvider.of<DateTimeSelectionBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Picker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _showDatePicker(context, dateTimeSelectionBloc);
              },
              child: Text('Select Date'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _showTimePicker(
                    context, DateTimeSelectionType.StartTime, dateTimeSelectionBloc);
              },
              child: Text('Select Start Time'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _showTimePicker(
                    context, DateTimeSelectionType.EndTime, dateTimeSelectionBloc);
              },
              child: Text('Select End Time'),
            ),
            const SizedBox(height: 32.0),
            BlocBuilder<DateTimeSelectionBloc, DateTimeSelectionState>(
              builder: (context, state) {
                final selectedDate = (state is DateTimeSelectedState &&
                        state.selectionType == DateTimeSelectionType.Date)
                    ? state.dateTime
                    : null;

                final selectedStartTime = (state is DateTimeSelectedState &&
                        state.selectionType == DateTimeSelectionType.StartTime)
                    ? state.dateTime
                    : null;

                final selectedEndTime = (state is DateTimeSelectedState &&
                        state.selectionType == DateTimeSelectionType.EndTime)
                    ? state.dateTime
                    : null;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Selected Date: ${selectedDate ?? ''}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Selected Start Time: ${selectedStartTime ?? ''}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Selected End Time: ${selectedEndTime ?? ''}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                );
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Continue reservation logic
              },
              child: Text('Continue Reservation'),
            ),
          ],
        ),
      ),
    );
  }

  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// BLoC
enum DateTimeSelectionType {
  Date,
  StartTime,
  EndTime,
}

abstract class DateTimeSelectionEvent {}

class DateTimeSelectedEvent extends DateTimeSelectionEvent {
  final DateTime dateTime;
  final DateTimeSelectionType selectionType;

  DateTimeSelectedEvent(this.dateTime, this.selectionType);
}

abstract class DateTimeSelectionState {}

class InitialState extends DateTimeSelectionState {}

class DateTimeSelectedState extends DateTimeSelectionState {
  final DateTime dateTime;
  final DateTimeSelectionType selectionType;

  DateTimeSelectedState(this.dateTime, this.selectionType);
}

class DateTimeSelectionBloc
    extends Bloc<DateTimeSelectionEvent, DateTimeSelectionState> {
  DateTimeSelectionBloc() : super(InitialState());

  @override
  Stream<DateTimeSelectionState> mapEventToState(
      DateTimeSelectionEvent event) async* {
    if (event is DateTimeSelectedEvent) {
      yield DateTimeSelectedState(event.dateTime, event.selectionType);
    }
  }
}

// App
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Time Picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => DateTimeSelectionBloc(),
        child: TimePickerPage(),
      ),
    );
  }
}

class TimePickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dateTimeSelectionBloc =
        BlocProvider.of<DateTimeSelectionBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Picker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _showDatePicker(context, dateTimeSelectionBloc);
              },
              child: Text('Select Date'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _showTimePicker(
                    context, DateTimeSelectionType.StartTime, dateTimeSelectionBloc);
              },
              child: Text('Select Start Time'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _showTimePicker(
                    context, DateTimeSelectionType.EndTime, dateTimeSelectionBloc);
              },
              child: Text('Select End Time'),
            ),
            const SizedBox(height: 32.0),
            BlocBuilder<DateTimeSelectionBloc, DateTimeSelectionState>(
              builder: (context, state) {
                final selectedDate = (state is DateTimeSelectedState &&
                        state.selectionType == DateTimeSelectionType.Date)
                    ? state.dateTime
                    : null;

                final selectedStartTime = (state is DateTimeSelectedState &&
                        state.selectionType == DateTimeSelectionType.StartTime)
                    ? state.dateTime
                    : null;

                final selectedEndTime = (state is DateTimeSelectedState &&
                        state.selectionType == DateTimeSelectionType.EndTime)
                    ? state.dateTime
                    : null;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Selected Date: ${selectedDate ?? ''}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Selected Start Time: ${selectedStartTime ?? ''}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Selected End Time: ${selectedEndTime ?? ''}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                );
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Continue reservation logic
              },
              child: Text('Continue Reservation'),
            ),
          ],
        ),
      ),
    );
  }

Future<Null> _showDatePicker(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101));
  if (picked != null)
    setState(() {
      selectedDate = picked;
      _dateController.text = DateFormat.yMd().format(selectedDate);
    });
}

  Future<void> _showTimePicker(BuildContext context, DateTimeSelectionType selectionType, DateTimeSelectionBloc bloc) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final selectedDateTime = DateTime.now().add(
        Duration(hours: picked.hour, minutes: picked.minute),
      );

      bloc.add(DateTimeSelectedEvent(selectedDateTime, selectionType));
    }
  }
}


  Future<void> _showTimePicker(BuildContext context, DateTimeSelectionType selectionType, DateTimeSelectionBloc bloc) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final selectedDateTime = DateTime.now().add(
        Duration(hours: picked.hour, minutes: picked.minute),
      );

      bloc.add(DateTimeSelectedEvent(selectedDateTime, selectionType));
    }
  }
}


  Future<void> _showTimePicker(BuildContext context,
      DateTimeSelectionType selectionType, DateTimeSelectionBloc bloc) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final selectedDateTime = DateTime.now().add(
        Duration(hours: picked.hour, minutes: picked.minute),
      );

      bloc.add(DateTimeSelectedEvent(selectedDateTime, selectionType));
    }
  }
}
