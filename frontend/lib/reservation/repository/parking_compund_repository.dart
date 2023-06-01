class ParkingCompoundRepository {
  final Reservation.ParkingCompoundDataProvider dataProvider;

  ParkingCompoundRepository({
    required this.dataProvider,
    required Reservation.ParkingCompoundDataProvider compoundDataProvider,
  });

  Future<List<ReservationModel.ParkingCompound>>
      getAllParkingCompounds() async {
    try {
      return await dataProvider.getAllParkingCompounds();
    } catch (e) {
      // Handle the error
      print('Failed to fetch parking compounds: $e');
      throw Exception('Failed to fetch parking compounds');
    }
  }

  Future<String> getLocationById(int id) async {
    try {
      return await dataProvider.getLocationById(id);
    } catch (e) {
      // Handle the error
      print('Failed to fetch location: $e');
      throw Exception('Failed to fetch location');
    }
  }

  Future<double> getPriceById(int id) async {
    try {
      return await dataProvider.getPriceById(id);
    } catch (e) {
      // Handle the error
      print('Failed to fetch price: $e');
      throw Exception('Failed to fetch price');
    }
  }
}
