class ParkingSpotRepository {
  static const int itemsPerPage = 20;

  final ParkingSpotDataProvider parkingSpotDataProvider;

  ParkingSpotRepository({required this.parkingSpotDataProvider});

  Future<List<ParkingSpot>> fetchParkingSpots(int page) async {
    try {
      final List<ParkingSpot> parkingSpots =
          await parkingSpotDataProvider.fetchParkingSpots(page);
      return parkingSpots;
    } catch (e) {
      throw Exception('Failed to fetch parking spots: $e');
    }
  }
}
