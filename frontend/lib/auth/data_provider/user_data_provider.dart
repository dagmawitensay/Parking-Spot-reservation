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
      final responseBody = jsonDecode(response.body);

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
          'first_name': reserver.email,
          'last_name': reserver.lastName
        }));
    print(response.body);
    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      persitstToken(responseBody['access_token'], responseBody['role']);
      print(responseBody['access_token']);
      var role = responseBody['role'];
      reserver.role = role;
      return reserver;
    } else {
      throw Exception(jsonDecode(response.body)['message']
          ? jsonDecode(response.body)['message']
          : 'Operation Failure');
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

  Future<void> deleteAccount() async {
    var token = await getToken();
    var user_id = await JwtDecoder.decode(token!)['sub'];
    final response = await http.delete(
        Uri.parse(
          'http://localhost:3000/user/$user_id',
        ),
        headers: <String, String>{'Authorization': 'Bearer $token'});
    if (!(response.statusCode == 200 || response.statusCode == 204)) {
      throw Exception('Failed to delete Profile');
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
