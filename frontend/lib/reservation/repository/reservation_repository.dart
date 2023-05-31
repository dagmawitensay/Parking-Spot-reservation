import 'package:frontend/reservation/data_provider/reservation_data_provider.dart';
import 'package:frontend/reservation/models/reservation.dart';

class ReservationRepository {
  final ReservationDataProvider dataProvider;

  ReservationRepository(this.dataProvider);

  Future<List<Reservation>> getReservationsForUser(String userId) async {
    return dataProvider.getReservationsForUser(userId);
  }

  Future<void> createReservation(
    Reservation reservation, {
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final reservation = Reservation(
      id: '', // Generate or assign an appropriate ID for the reservation
      userId: '', // Provide the user ID associated with the reservation
      startTime: startTime,
      endTime: endTime,
      spotId: '', // Provide the spot ID for the reservation
      createdat: '', // Provide the appropriate value for the creation timestamp
    );

    return dataProvider.createReservation(reservation);
  }

  Future<void> updateReservation(Reservation reservation) async {
    return dataProvider.updateReservation(reservation);
  }

  Future<void> cancelReservation(String reservationId) async {
    return dataProvider.cancelReservation(reservationId);
  }

  Future<List<Reservation>> getAllReservations() async {
    return dataProvider.getAllReservations();
  }
}
