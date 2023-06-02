abstract class ReservationEvent {}

class CheckAvailabilityEvent extends ReservationEvent {
  final int parkingSpotId;
  final DateTime startTime;
  final DateTime endTime;

  CheckAvailabilityEvent({
    required this.parkingSpotId,
    required this.startTime,
    required this.endTime,
  });
}
