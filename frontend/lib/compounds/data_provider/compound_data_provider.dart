import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../models/compound.dart';
import 'package:http/http.dart' as http;

// 10.0.2.2
class CompoundDataProvider {
  static const String _baseUrl = 'http://localhost:3000/parking-compounds';
  late final FlutterSecureStorage storage = new FlutterSecureStorage();

  Future<Compound> createCompound(Compound compound) async {
    var token = await storage.read(key: 'token');
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
        // 'Authorization':
        //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImVtYWlsIjoibWF0ZXdvc0BnbWFpbC5jb20iLCJyb2xlIjoib3duZXIiLCJpYXQiOjE2ODU1NTkwNjksImV4cCI6MTY4NTU4MDY2OX0.SdezKzNYTR_Y-ne2dKs8pJCt2qhne6fb2HepCYVL118'
      },
      body: jsonEncode(<String, dynamic>{
        'id': compound.id,
        'name': compound.name,
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
    print(response.body);
    print(token);
    print(compound.name);
    if (response.statusCode == 201) {
      return Compound.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load compound');
    }
  }

  Future<Compound> getCompound(int id) async {
    var token = await storage.read(key: 'token');
    final response = await http.get(Uri.parse('$_baseUrl/$id'),
        headers: <String, String>{'Authorization': 'Bearer $token'});
    print(Uri.parse('$_baseUrl/$id'));
    print(response.body);
    if (response.statusCode == 200) {
      return Compound.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load compound');
    }
  }

  Future<Compound> updateCompound(Compound compound) async {
    var token = await storage.read(key: 'token');
    final http.Response response = await http.put(
      Uri.parse('$_baseUrl/${compound.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'id': compound.id,
        'name': compound.name,
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
    var token = await storage.read(key: 'token');
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
    print("start");
    final http.Response response = await http.get(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
    var token = await storage.read(key: 'token');
    final http.Response response = await http.get(
      Uri.parse('http://10.0.2.2:3000/parking-compounds/$ownerId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
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
    var token = await storage.read(key: 'token');
    final http.Response response =
        await http.delete(Uri.parse('$_baseUrl/$id'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
      // 'Authorization':
      //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImVtYWlsIjoibWF0ZXdvc0BnbWFpbC5jb20iLCJyb2xlIjoib3duZXIiLCJpYXQiOjE2ODU1NTkwNjksImV4cCI6MTY4NTU4MDY2OX0.SdezKzNYTR_Y-ne2dKs8pJCt2qhne6fb2HepCYVL118'
    });

    print(response.body);
    if (!(response.statusCode == 200 || response.statusCode == 204)) {
      throw Exception('Failed to delete compound');
    }
  }
}
