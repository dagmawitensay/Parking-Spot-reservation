import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/auth.dart';

class UserDataProvider {
  static const String _baseUrl = 'http://localhost:3000/auth';

  Future<CompoundOwner> signUpCompoundOwner(CompoundOwner owner) async {
    print("In data provider sign up owner");
    final response = await http.post(
      Uri.parse('$_baseUrl/owner/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': owner.username,
        'email': owner.email,
        'password': owner.password,
        'firstName': owner.firstName,
        'lastName': owner.lastName,
      }),
    );

    if (response.statusCode == 201) {
      return CompoundOwner.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
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
      return SpotReservingUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<User> signIn(User user) async {
    final response = await http.post(Uri.parse('$_baseUrl/signin'),
        headers: <String, String>{
          'Content-Type': 'application/josn; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'username': user.email,
          'password': user.password,
        }));

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Credentials not correct');
    }
  }
}
