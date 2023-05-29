class Compound {
  int? id;
  int ownerId;
  String Region;
  String Wereda;
  String Zone;
  // String City;
  String Kebele;
  double SlotPricePerHour;
  int availableSpots;
  int totalSpots;

  Compound(
      {this.id,
      required this.Region,
      required this.Wereda,
      required this.Zone,
      // required this.City,
      required this.Kebele,
      required this.SlotPricePerHour,
      required this.availableSpots,
      required this.totalSpots,
      required this.ownerId});

  factory Compound.fromJson(Map<String, dynamic> json) {
    return Compound(
        id: json['id'],
        Region: json['Region'],
        Wereda: json['Wereda'],
        Zone: json['Zone'],
        // City: json['City'],
        Kebele: json['Kebele'],
        SlotPricePerHour: double.parse(json['price']),
        availableSpots: json['available_spots'],
        totalSpots: json['total_spots'],
        ownerId: json['owner_id']);
  }
}
