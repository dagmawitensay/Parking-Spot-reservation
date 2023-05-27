import 'dart:convert';

import '../models/compound.dart';
import 'package:http/http.dart' as http;

class CompoundDataProvider {
  static const String _baseUrl = 'http://localhost:3000/parking-compounds';

  Future<Compound> createCompound(Compound compound) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': compound.id,
        'Region': compound.Region,
        'Wereda': compound.Wereda,
        'Zone': compound.Zone,
        // 'City': compound.City,
        'Kebele': compound.Kebele,
        'price': compound.SlotPricePerHour,
        'available_spots': compound.availableSpots,
        'total_spots': compound.totalSpots,
        'owner_id': compound.ownerId,
      }),
    );
    if (response.statusCode == 201) {
      return Compound.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load compound');
    }
  }

  Future<Compound> getCompound(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));
    print(Uri.parse('$_baseUrl/$id'));
    print(response.body);
    if (response.statusCode == 200) {
      return Compound.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load compound');
    }
  }

  Future<void> updateCompound(int id, Compound compound) async {
    final http.Response response = await http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': compound.id,
        'Region': compound.Region,
        'Wereda': compound.Wereda,
        'Zone': compound.Zone,
        // 'City': compound.City,
        'Kebele': compound.Kebele,
        'SlotPricePerHour': compound.SlotPricePerHour,
        'availableSpots': compound.availableSpots,
        'totalSpots': compound.totalSpots,
        'owner_id': compound.ownerId,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to load Compound');
    }
  }

  Future<List<Compound>> fetchCompounds(int userId) async {
    final http.Response response = await http
        .get(Uri.parse('$_baseUrl/$userId'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Compound> compounds = List<Compound>.from(
        data.map((dynamic item) => Compound.fromJson(item)),
      );
      return compounds;
    } else {
      throw Exception('Failed to load compounds');
    }
  }

  Future<List<Compound>> fetchAll() async {
    print("mother fucker fetching");
    final http.Response response = await http.get(
      Uri.parse('http://localhost:3000/parking-compounds'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Compound> compounds = List<Compound>.from(
        data.map((dynamic item) => Compound.fromJson(item)),
      );
      return compounds;
    } else {
      throw Exception('Falied to load compounds');
    }
  }

  Future<void> deleteCompound(int id) async {
    final http.Response reponse =
        await http.delete(Uri.parse('$_baseUrl/$id'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (reponse.statusCode != 204) {
      throw Exception('Failed to delete compound');
    }
  }
}

// void main() {
//   CompoundDataProvider dataproviders = CompoundDataProvider();
//   Compound compound = Compound(
//       City: 'Assela',
//       Region: 'Oromia',
//       Wereda: 'Assela',
//       Zone: 'Arsi',
//       Kebele: 10,
//       availableSpots: 3,
//       totalSpots: 3,
//       SlotPricePerHour: 100,
//       ownerId: 1);
//   //print(dataproviders.createCompound(compound));
//   print(dataproviders.getCompound(1));
// }

void main() {
  CompoundDataProvider dataproviders = CompoundDataProvider();
  print(dataproviders.fetchAll());
}
