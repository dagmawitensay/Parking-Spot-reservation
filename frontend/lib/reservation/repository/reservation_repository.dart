import 'package:frontend/reservation/data_provider/reservation_data_provider.dart';
import 'package:frontend/reservation/models/reservation.dart';

class ReservationRepository {
  final ReservationDataProvider dataProvider;

  ReservationRepository(this.dataProvider);

  Future<List<Reservation>> getReservationsForUser() async {
    return dataProvider.getReservationsForUser();
  }

  Future<Reservation> createReservation(
      startTime, endTime, price, plateNo, spotId) async {
    return dataProvider.createReservation(
        startTime, endTime, price, plateNo, spotId);
  }

  Future hasReservations(compoundId, startTime, endTime) {
    return dataProvider.hasAvailableSpots(compoundId, startTime, endTime);
  }

  Future calculatePrice(compoundId, startTime, endTime) async {
    return await dataProvider.calculatePrice(compoundId, startTime, endTime);
  }

  Future<void> updateReservation(Reservation reservation) async {
    return dataProvider.updateReservation(reservation);
  }

  Future<void> deleteReservation(int reservationId) async {
    return dataProvider.deleteReservation(reservationId);
  }

  Future<List<Reservation>> getAllReservations() async {
    return dataProvider.getAllReservations();
  }
}
