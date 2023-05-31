import 'package:frontend/reservation/bloc/reservation_bloc.dart';

class ReservationSuccess extends ReservationState {
  final String message;

  ReservationSuccess(this.message);
}
