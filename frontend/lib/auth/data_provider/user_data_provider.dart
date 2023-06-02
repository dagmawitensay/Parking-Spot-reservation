import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/compounds/models/compound.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth.dart';

//10.0.2.2
class UserDataProvider {
  static const String _baseUrl = 'http://10.0.2.2:3000/auth';
  SharedPreferences? prefs;
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  Future<CompoundOwner> signUpCompoundOwner(CompoundOwner owner) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/owner/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': owner.username,
        'email': owner.email,
        'password': owner.password,
        'first_name': owner.firstName,
        'last_name': owner.lastName,
      }),
    );

    print(response.body);
    print('$_baseUrl/owner/signup');

    if (response.statusCode == 201) {
      final responseBody = json.decode(response.body);

      persitstToken(responseBody['access_token'], responseBody['role']);

      return owner;
    } else {
      throw Exception('Failed to create owner');
    }
  }

  Future<SpotReservingUser> signUpSpotReserver(
      SpotReservingUser reserver) async {
    final response = await http.post(Uri.parse('$_baseUrl/parker/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'username': reserver.username,
          'email': reserver.email,
          'password': reserver.password,
          'firstName': reserver.email,
          'lastName': reserver.lastName
        }));

    if (response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      persitstToken(responseBody['access_token'], responseBody['role']);
      return SpotReservingUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<User> signIn(User user) async {
    print("entry to signin");
    final response = await http.post(
      Uri.parse('$_baseUrl/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': user.email,
        'password': user.password,
      }),
    );

    if (response.statusCode == 201) {
      user.role = jsonDecode(response.body)['role'];
      final responseBody = json.decode(response.body);

      persitstToken(responseBody['access_token'], responseBody['role']);
      return user;
    } else {
      throw Exception('Failed to create owner');
    }
  }

  Future<bool> isValidToken(String token) async {
    return !(JwtDecoder.isExpired(token));
  }

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    return value != null;
  }

  Future<String?> getToken() async {
    var value = await storage.read(key: 'token');
    print(value);
    print(JwtDecoder.isExpired(value!));
    return value;
  }

  Future<void> persitstToken(String token, String role) async {
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'role', value: role);
  }

  Future<void> deleteToken() async {
    
     storage.deleteAll();
  }

  Future<String> getRole() async {
    var role = await storage.read(key: 'role');
    return role!;
  }
}
