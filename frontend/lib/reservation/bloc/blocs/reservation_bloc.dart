import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/reservation/bloc/events/reservation_event.dart';
import 'package:frontend/reservation/bloc/states/reservation_state.dart';
import 'package:frontend/reservation/repository/reservation_repository.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationRepository reservationRepository;

  ReservationBloc({required this.reservationRepository})
      : super(ReservationLoading()) {
    on<ParkingSpotLoad>((event, emit) async {
      emit(ParkingSpotsLoading());
      try {
        print("failed in here");
        final parkingSpotsData = await reservationRepository.hasReservations(
            event.compoundId, event.startTime, event.endTime);
        emit(ParkingSpotsSucess(parkingSpotsData));
      } catch (error) {
        emit(ParkingSpotFailure(error.toString()));
      }
    });

    on<PriceCalculation>((event, emit) async {
      final price = await reservationRepository.calculatePrice(
          event.compoundId, event.startTime, event.endTime);
      emit(PriceCalculated(price));
    });

    on<ReservationLoad>((event, emit) async {
      emit(ReservationLoading());
      try {
        print("before reservation");
        final reservations =
            await reservationRepository.getReservationsForUser();
        print("after reservation");
        print(reservations);
        emit(ReservationOperationSucess(reservations));
      } catch (error) {
        emit(ReservationFailure(error.toString()));
      }
    });

    on<ReservationDelete>((event, emit) async {
      try {
        await reservationRepository.deleteReservation(event.id);
        final reservations =
            await reservationRepository.getReservationsForUser();
        emit(ReservationOperationSucess(reservations));
      } catch (error) {
        emit(ReservationFailure(error.toString()));
      }
    });

    on<ReserveSpot>((event, emit) async {
      try {
        print('making reservation');
        final reservation = await this.reservationRepository.createReservation(
            event.startTime,
            event.endTime,
            event.price,
            event.plateNo,
            event.spot_id);
        print(reservation);
        emit(ReservationSuccess(reservation));
      } catch (error) {
        ReservationFailure(error.toString());
      }
    });
  }
}
