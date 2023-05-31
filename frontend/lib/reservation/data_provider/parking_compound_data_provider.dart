import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/compounds/models/compound.dart' as Compounds;
// import 'package:frontend/reservation/models/parking_compound.dart'
//     as Reservation;

class CompoundDataProvider {
  static const String _baseUrl = 'http://localhost:3000/compounds';

  Future<List<Compounds.Compound>> fetchAll() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Compounds.Compound> compounds = data
          .map((dynamic item) => Compounds.Compound.fromJson(item))
          .toList();
      return compounds;
    } else {
      throw Exception('Failed to fetch compounds');
    }
  }

  Future<String> getLocationById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      return data['location'];
    } else {
      throw Exception('Failed to load location');
    }
  }

  Future<double> getPriceById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      return data['price'].toDouble();
    } else {
      throw Exception('Failed to load price');
    }
  }
}
