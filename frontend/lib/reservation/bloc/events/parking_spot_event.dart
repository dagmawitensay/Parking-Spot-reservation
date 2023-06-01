import 'package:equatable/equatable.dart';

abstract class ParkingSpotEvent extends Equatable {
  const ParkingSpotEvent();

  @override
  List<Object> get props => [];
}

class LoadParkingSpots extends ParkingSpotEvent {
  final int page;

  const LoadParkingSpots({required this.page});

  @override
  List<Object> get props => [page];
}
