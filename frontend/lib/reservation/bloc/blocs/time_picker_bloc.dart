import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/reservation/bloc/events/time_picker_event.dart';
import 'package:frontend/reservation/bloc/states/time_picker_state.dart';

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

class TimePickerBloc extends Bloc<TimePickerEvent, TimePickerState> {
  TimePickerBloc()
      : super(TimePickerState(
          startTime: TimeOfDay.now(),
          endTime: TimeOfDay.now(),
          date: DateTime.now(),
        ));

  @override
  Stream<TimePickerState> mapEventToState(TimePickerEvent event) async* {
    if (event is StartTimeChanged) {
      yield state.copyWith(startTime: event.startTime);
    } else if (event is EndTimeChanged) {
      yield state.copyWith(endTime: event.endTime);
    } else if (event is DateChanged) {
      yield state.copyWith(date: event.date);
    }
  }
}
