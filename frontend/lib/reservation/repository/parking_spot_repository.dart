import 'package:frontend/reservation/data_provider/parking_spot_data_provider.dart';
import 'package:frontend/reservation/models/parking_spot.dart';

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
