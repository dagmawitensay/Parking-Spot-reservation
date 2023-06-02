class Reservation {
  int? id;
  int userId;
  String startTime;
  String endTime;
  int spotId;

  Reservation({
    this.id,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.spotId,
    // required this.City,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      userId: json['user_id'],
      spotId: json['parking_spot_id'],
      // City: json['City'],
      // price: json['price'],
      // plateNo: json['plateNo'],
    );
  }
}
