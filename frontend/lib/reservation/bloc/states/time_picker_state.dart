import 'package:equatable/equatable.dart';

abstract class TimePickerState extends Equatable {
  const TimePickerState();

  @override
  List<Object?> get props => [];
}

class TimePickerInitial extends TimePickerState {}

class StartTimeSelected extends TimePickerState {
  final DateTime startTime;

  const StartTimeSelected(this.startTime);

  @override
  List<Object?> get props => [startTime];
}

class EndTimeSelected extends TimePickerState {
  final DateTime endTime;

  const EndTimeSelected(this.endTime);

  @override
  List<Object?> get props => [endTime];
}

class DateSelected extends TimePickerState {
  final DateTime startTime;
  final DateTime endTime;

  const DateSelected(this.startTime, this.endTime);

  @override
  List<Object?> get props => [startTime, endTime];
}
