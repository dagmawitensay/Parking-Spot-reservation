import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:frontend/reservation/models/reservation.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();
  @override
  List<Object> get props => [];
}

class ParkingSpotLoad extends ReservationEvent {
  final int compoundId;
  final DateTime date;
  final String startTime;
  final String endTime;
  const ParkingSpotLoad(
      this.compoundId, this.date, this.startTime, this.endTime);
}

class StartTimeChanged extends ReservationEvent {
  final TimeOfDay startTime;

  const StartTimeChanged(this.startTime);
}

class EndTimeChanged extends ReservationEvent {
  final TimeOfDay endTime;

  EndTimeChanged(this.endTime);
}

class Next extends ReservationEvent {
  final int compound_id;
  final String startTime;
  final String endTime;
  final DateTime date;

  const Next(this.compound_id, this.startTime, this.endTime, this.date);
}

class PriceCalculation extends ReservationEvent {
  final String startTime;
  final String endTime;
  final int compoundId;
  const PriceCalculation({
    required this.startTime,
    required this.endTime,
    required this.compoundId,
  });
}

class ReserveSpot extends ReservationEvent {
  final String startTime;
  final String endTime;
  final int spot_id;
  final double price;
  final String plateNo;

  const ReserveSpot(
      {required this.startTime,
      required this.endTime,
      required this.spot_id,
      required this.plateNo,
      required this.price});
}

class ReservationLoad extends ReservationEvent {
  const ReservationLoad();
  @override
  List<Object> get props => [];
}

class ReservationUpdate extends ReservationEvent {
  final int id;
  final Reservation reservation;

  const ReservationUpdate(this.id, this.reservation);
  @override
  List<Object> get props => [id, reservation];
}

class ReservationDelete extends ReservationEvent {
  final int id;

  const ReservationDelete(this.id);

  @override
  List<Object> get props => [id];
}
