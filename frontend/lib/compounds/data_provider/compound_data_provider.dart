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
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImVtYWlsIjoibWF0ZXdvc0BnbWFpbC5jb20iLCJyb2xlIjoib3duZXIiLCJpYXQiOjE2ODUzNTU4NTUsImV4cCI6MTY4NTM3NzQ1NX0.DfMFO_XTUHLWaW9LpRXlgdjUYs9XdJs3AylJBhCZALM'
      },
      body: jsonEncode(<String, dynamic>{
        'id': compound.id,
        // 'name': compound.name,
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
    final response =
        await http.get(Uri.parse('$_baseUrl/$id'), headers: <String, String>{
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImVtYWlsIjoibWF0ZXdvc0BnbWFpbC5jb20iLCJyb2xlIjoib3duZXIiLCJpYXQiOjE2ODUzNTU4NTUsImV4cCI6MTY4NTM3NzQ1NX0.DfMFO_XTUHLWaW9LpRXlgdjUYs9XdJs3AylJBhCZALM'
    });
    print(Uri.parse('$_baseUrl/$id'));
    print(response.body);
    if (response.statusCode == 200) {
      return Compound.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load compound');
    }
  }

  Future<Compound> updateCompound(Compound compound) async {
    final http.Response response = await http.put(
      Uri.parse('$_baseUrl/${compound.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImVtYWlsIjoibWF0ZXdvc0BnbWFpbC5jb20iLCJyb2xlIjoib3duZXIiLCJpYXQiOjE2ODUzNTU4NTUsImV4cCI6MTY4NTM3NzQ1NX0.DfMFO_XTUHLWaW9LpRXlgdjUYs9XdJs3AylJBhCZALM'
      },
      body: jsonEncode(<String, dynamic>{
        'id': compound.id,
        // 'name': compound.name,
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
    if (response.statusCode == 204 || response.statusCode == 200) {
      return compound;
    } else {
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
    final http.Response response = await http.get(
      Uri.parse('http://localhost:3000/parking-compounds'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImVtYWlsIjoibWF0ZXdvc0BnbWFpbC5jb20iLCJyb2xlIjoib3duZXIiLCJpYXQiOjE2ODUzNTU4NTUsImV4cCI6MTY4NTM3NzQ1NX0.DfMFO_XTUHLWaW9LpRXlgdjUYs9XdJs3AylJBhCZALM'
      },
    );
    print(response.body);
    print("after excution");
    print(response.statusCode);
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

  
  Future<List<Compound>> fetchAllOwner(int ownerId) async {
    final http.Response response = await http.get(
      Uri.parse('http://localhost:3000/parking-compounds/$ownerId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImVtYWlsIjoibWF0ZXdvc0BnbWFpbC5jb20iLCJyb2xlIjoib3duZXIiLCJpYXQiOjE2ODUzNTU4NTUsImV4cCI6MTY4NTM3NzQ1NX0.DfMFO_XTUHLWaW9LpRXlgdjUYs9XdJs3AylJBhCZALM'
      },
    );
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
    final http.Response response =
        await http.delete(Uri.parse('$_baseUrl/$id'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImVtYWlsIjoibWF0ZXdvc0BnbWFpbC5jb20iLCJyb2xlIjoib3duZXIiLCJpYXQiOjE2ODUzNTU4NTUsImV4cCI6MTY4NTM3NzQ1NX0.DfMFO_XTUHLWaW9LpRXlgdjUYs9XdJs3AylJBhCZALM'
    });

    if (!(response.statusCode == 200 || response.statusCode == 204)) {
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

