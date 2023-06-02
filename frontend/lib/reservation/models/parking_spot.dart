class ParkingSpot {
  final int id;
  final int compoundId;

  ParkingSpot({
    required this.id,
    required this.compoundId,
  });

  
  factory ParkingSpot.fromJson(Map<String, dynamic> json) {
    return ParkingSpot(
      id: json['id'],
      compoundId: json['compound_id'],
      
    );
  }
}
