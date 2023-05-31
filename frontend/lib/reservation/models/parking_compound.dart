class Compound {
  final String owner_id;
  final double price;
  final int availableSpots;
  final int totalSpots;
  final String createdAt;
  final String compoundName;
  final String Wereda;
  final String Kebele;
  final String Region;
  final String Zone;
  final int id;

  Compound({
    required this.owner_id,
    required this.price,
    required this.availableSpots,
    required this.totalSpots,
    required this.createdAt,
    required this.compoundName,
    required this.Wereda,
    required this.Kebele,
    required this.Region,
    required this.Zone,
    required this.id,
  });

  factory Compound.fromJson(Map<String, dynamic> json) {
    return Compound(
      owner_id: json['owner_id'],
      price: json['price'].toDouble(),
      availableSpots: json['available_spots'],
      totalSpots: json['total_spots'],
      createdAt: json['createdAt'],
      compoundName: json['compoundName'],
      Wereda: json['Wereda'],
      Kebele: json['Kebele'],
      Region: json['Region'],
      Zone: json['Zone'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'owner_id': owner_id,
      'price': price,
      'available_spots': availableSpots,
      'total_spots': totalSpots,
      'createdAt': createdAt,
      'compoundName': compoundName,
      'Wereda': Wereda,
      'Kebele': Kebele,
      'Region': Region,
      'Zone': Zone,
      'id': id,
    };
  }
}
