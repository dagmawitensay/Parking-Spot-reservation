import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/reservation/bloc/time_picker_event.dart';
import 'package:frontend/reservation/bloc/time_picker_state.dart';

class TimePickerBloc extends Bloc<TimePickerEvent, TimePickerState> {
  TimePickerBloc() : super(TimePickerInitial()) {
    on<SelectStartTime>(
        (event, emit) => emit(StartTimeSelected(DateTime.now())));
    on<SelectEndTime>((event, emit) => emit(EndTimeSelected(DateTime.now())));
    on<SelectDate>(
        (event, emit) => emit(DateSelected(DateTime.now(), DateTime.now())));
  }
}
