import 'package:equatable/equatable.dart';

import '../models/parking_spot.dart';

abstract class ParkingSpotState extends Equatable {
  const ParkingSpotState();

  @override
  List<Object> get props => [];
}

class ParkingSpotInitial extends ParkingSpotState {}

class ParkingSpotLoading extends ParkingSpotState {}

class ParkingSpotLoaded extends ParkingSpotState {
  final List<ParkingSpot> parkingSpots;
  final bool hasMoreData;

  const ParkingSpotLoaded(
      {required this.parkingSpots, required this.hasMoreData});

  @override
  List<Object> get props => [parkingSpots, hasMoreData];
}

class ParkingSpotError extends ParkingSpotState {}
