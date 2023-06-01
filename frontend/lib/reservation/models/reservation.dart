class Reservation {
  final String? id;
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final String spotId;

  Reservation({
    this.id,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.spotId,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      userId: json['userId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      spotId: json['spotId'], // Fix the key here
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'spotId': spotId,
    };
  }
}
