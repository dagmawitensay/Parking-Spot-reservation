class ParkingCompound {
  final String owner_id;
  // final String location;
  final double price;
  final int availableSpots;
  final int totalSpots;
  final String createdAt;
  final String name;
  final String Wereda;
  final String Kebele;
  final String Region;
  final String Zone;
  final int id;

  // final String imageUrl;

  ParkingCompound(
      {required this.owner_id,
      // required this.location,
      required this.price,
      required this.availableSpots,
      required this.totalSpots,
      required this.createdAt,
      required this.Kebele,
      required this.Wereda,
      required this.Region,
      required this.name,
      required this.Zone,
      required this.id

      // required this.imageUrl
      });

  factory ParkingCompound.fromJson(Map<String, dynamic> json) {
    return ParkingCompound(
        owner_id: json['owner_id'],
        // location: json['location'],
        price: json['price'].toDouble(),
        availableSpots: json['available_spots'],
        totalSpots: json['total_spots'],
        createdAt: json['createdAt'],
        Kebele: json['Kebele'],
        Wereda: json['Wereda'],
        Region: json['Region'],
        name: json['name'],
        Zone: json['Zone'],
        id: json['id']

        // imageUrl: json['imageUrl']
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'owner_id': owner_id,
      // 'location': location,
      'price': price,
      'available_spots': availableSpots,
      'total_spots': totalSpots,
      'createdAt': createdAt,
      'name': name,
      'Zone': Zone,
      'Wereda': Wereda,
      'Region': Region,
      'Kebele': Kebele,
      'id': id
    };
  }
}
