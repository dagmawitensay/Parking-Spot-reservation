import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

// Events
abstract class TimePickerEvent extends Equatable {
  const TimePickerEvent();
  @override
  List<Object> get props => [];
}

class StartTimeChanged extends TimePickerEvent {
  final TimeOfDay startTime;

  StartTimeChanged({required this.startTime});
}

class EndTimeChanged extends TimePickerEvent {
  final TimeOfDay endTime;

  EndTimeChanged({required this.endTime});
}

class DateChanged extends TimePickerEvent {
  final DateTime date;

  DateChanged({required this.date});
}




