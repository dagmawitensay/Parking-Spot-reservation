import 'package:frontend/reservation/data_provider/parking_compound_data_provider.dart';
import 'package:frontend/reservation/models/parking_compound.dart';

class ParkingCompoundRepository {
  final ParkingCompoundDataProvider dataProvider;

  ParkingCompoundRepository(this.dataProvider, {required compoundDataProvider});

  Future<List<ParkingCompound>> getAllParkingCompounds() async {
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
