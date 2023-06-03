import 'package:equatable/equatable.dart';
import 'package:frontend/reservation/models/reservation.dart';

class ReservationState extends Equatable {
  const ReservationState();

  @override
  List<Object> get props => [];
}

class ReservationLoading extends ReservationState {}

class ParkingSpotInital extends ReservationState {}

class ParkingSpotsLoading extends ReservationState {}

class ParkingSpotsSucess extends ReservationState {
  final List<dynamic> parkingSpotsData;

  const ParkingSpotsSucess(this.parkingSpotsData);

  List<Object> get props => [parkingSpotsData];
}

class ParkingSpotFailure extends ReservationState {
  final String errorMessage;
  const ParkingSpotFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class PriceCalculated extends ReservationState {
  final double price;
  const PriceCalculated(this.price);

  @override
  List<Object> get props => [];
}

class ReservationSuccess extends ReservationState {
  final Reservation reservation;

  const ReservationSuccess(this.reservation);
}

class ReservationFailure extends ReservationState {
  final String errorMessage;

  const ReservationFailure(this.errorMessage);
}

class ReservationOperationSucess extends ReservationState {
  final List<dynamic> reservations;
  const ReservationOperationSucess(this.reservations);

  @override
  List<Object> get props => [];
}
