import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/reservation/bloc/time_picker_event.dart';
import 'package:frontend/reservation/bloc/time_picker_state.dart';

class TimePickerBloc extends Bloc<TimePickerEvent, TimePickerState> {
  
  TimePickerBloc() : super(TimePickerInitial()){
    on<SelectStartTime>((event, emit) async {
      emit(StartTimeSelected(DateTime.now()));
    });

    on<SelectEndTime>((event, emit) async {
      emit(EndTimeSelected(DateTime.now()));
    });

    on<SelectDate>((event,emit) async {
      emit(DateSelected(DateTime.now(), DateTime.now()));
    });
  }
}
