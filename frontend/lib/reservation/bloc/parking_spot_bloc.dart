import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/reservation/models/parking_spot.dart';
import 'package:frontend/reservation/repository/parking_spot_repository.dart';

part 'parking_spot_event.dart';
part 'parking_spot_state.dart';

class ParkingSpotBloc extends Bloc<ParkingSpotEvent, ParkingSpotState> {
  final ParkingSpotRepository parkingSpotRepository;

  ParkingSpotBloc({required this.parkingSpotRepository})
      : super(ParkingSpotInitial()) {
    on<LoadParkingSpots>(
        (event, emit) => _mapLoadParkingSpotsToState(event, emit));
  }

  void _mapLoadParkingSpotsToState(
      LoadParkingSpots event, Emitter<ParkingSpotState> emit) async {
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
    } catch (e) {
      emit(ParkingSpotError());
    }
  }
}
