import 'package:equatable/equatable.dart';

abstract class TimePickerEvent extends Equatable {
  const TimePickerEvent();

  @override
  List<Object?> get props => [];
}

class SelectStartTime extends TimePickerEvent {}

class SelectEndTime extends TimePickerEvent {}

class SelectDate extends TimePickerEvent {}
