import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/reservation/bloc/reservation_state.dart';
import 'package:frontend/reservation/models/reservation.dart';
import 'package:frontend/reservation/repository/reservation_repository.dart';

// Define the events for the ReservationBloc
abstract class ReservationEvent {}

class FetchReservations extends ReservationEvent {
  final String userId;

  FetchReservations(this.userId);
}

class CreateReservation extends ReservationEvent {
  final DateTime startTime;
  final DateTime endTime;

  CreateReservation(this.startTime, this.endTime);
}

class UpdateReservation extends ReservationEvent {
  final Reservation reservation;

  UpdateReservation(this.reservation);
}

class CancelReservation extends ReservationEvent {
  final String reservationId;

  CancelReservation(this.reservationId);
}

class BookingSuccessEvent extends ReservationEvent {}

class ReservationFailed extends ReservationState {
  final String errorMessage;

  ReservationFailed(this.errorMessage);
}

// Define the states for the ReservationBloc
abstract class ReservationState {}

class ReservationLoading extends ReservationState {
  ReservationLoading();
}

class ReservationLoaded extends ReservationState {
  final List<Reservation> reservations;

  ReservationLoaded(this.reservations);
}

class ReservationError extends ReservationState {
  final String errorMessage;

  ReservationError(this.errorMessage);
}

// Define the ReservationBloc
class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationRepository reservationRepository;

  ReservationBloc(this.reservationRepository) : super(ReservationLoading()) {
    on<FetchReservations>(
        (event, emit) => _mapFetchReservationsToState(event, emit));
    on<CreateReservation>(
        (event, emit) => _mapCreateReservationToState(event, emit));
    on<UpdateReservation>(
        (event, emit) => _mapUpdateReservationToState(event, emit));
    on<CancelReservation>(
        (event, emit) => _mapCancelReservationToState(event, emit));
    on<BookingSuccessEvent>(
        (event, emit) => _mapBookingSuccessEventToState(event, emit));
  }

  void _mapFetchReservationsToState(
      FetchReservations event, Emitter<ReservationState> emit) async {
    try {
      emit(ReservationLoading());
      final reservations =
          await reservationRepository.getReservationsForUser(event.userId);
      emit(ReservationLoaded(reservations));
    } catch (e) {
      emit(ReservationError('Failed to fetch reservations: $e'));
    }
  }

  void _mapCreateReservationToState(
      CreateReservation event, Emitter<ReservationState> emit) async {
    try {
      final reservation = Reservation(
        id: '', // Generate or assign an appropriate ID for the reservation
        userId: '', // Provide the user ID associated with the reservation
        startTime: event.startTime,
        endTime: event.endTime,
        spotId: '', // Provide the spot ID for the reservation
        createdat:
            '', // Provide the appropriate value for the creation timestamp
      );

      await reservationRepository.createReservation(
        reservation,
        startTime: event.startTime,
        endTime: event.endTime,
      );

      final allReservations = await reservationRepository.getAllReservations();
      emit(ReservationLoaded(allReservations));

      emit(ReservationSuccess('Booking successful')); // Emit the success state
    } catch (e) {
      emit(ReservationError('Failed to create reservation: $e'));
    }
  }

  void _mapUpdateReservationToState(
      UpdateReservation event, Emitter<ReservationState> emit) async {
    try {
      await reservationRepository.updateReservation(event.reservation);
      final allReservations = await reservationRepository.getAllReservations();
      emit(ReservationLoaded(allReservations));
    } catch (e) {
      emit(ReservationError('Failed to update reservation: $e'));
    }
  }

  void _mapCancelReservationToState(
      CancelReservation event, Emitter<ReservationState> emit) async {
    try {
      await reservationRepository.cancelReservation(event.reservationId);
      final allReservations = await reservationRepository.getAllReservations();
      emit(ReservationLoaded(allReservations));
    } catch (e) {
      emit(ReservationError('Failed to cancel reservation: $e'));
    }
  }

  void _mapBookingSuccessEventToState(
      BookingSuccessEvent event, Emitter<ReservationState> emit) {
    emit(ReservationSuccess('Booking successful!'));
  }
}
