import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/reservation/bloc/events/parking_spot_event.dart';
import 'package:frontend/reservation/bloc/states/parking_spot_state.dart';
import 'package:frontend/reservation/models/parking_spot.dart';
import 'package:frontend/reservation/repository/parking_spot_repository.dart';

class ParkingSpotBloc extends Bloc<ParkingSpotEvent, ParkingSpotState> {
  final ParkingSpotRepository parkingSpotRepository;

  ParkingSpotBloc({required this.parkingSpotRepository})
      : super(ParkingSpotInitial()) {
        on<LoadParkingSpots>((event, emit) async {
          try {
             emit(ParkingSpotLoading());
          final parkingSpots =
          await parkingSpotRepository.fetchParkingSpots(event.page);
      final typedParkingSpots =
          parkingSpots.cast<ParkingSpot>(); // Type casting
      final hasMoreData = typedParkingSpots.length >=
          event.page * ParkingSpotRepository.itemsPerPage;
          emit(ParkingSpotLoaded(
          parkingSpots: typedParkingSpots, hasMoreData: hasMoreData));
          } catch(e) {
            ParkingSpotError();
          }
        });
      }
}
