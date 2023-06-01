import 'dart:convert';
import 'package:frontend/compounds/models/compound.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth.dart';

class UserDataProvider {
  static const String _baseUrl = 'http://localhost:3000/auth';
  SharedPreferences? prefs;

  Future<CompoundOwner> signUpCompoundOwner(CompoundOwner owner) async {
    print(owner);
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
      final accessToken = responseBody['access_token'];
      final prefs = await SharedPreferences.getInstance();

      prefs.setString('access_token', accessToken);

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
      final accessToken = responseBody['access_token'];
      final prefs = await SharedPreferences.getInstance();

      prefs.setString('access_token', accessToken);
      return SpotReservingUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<User> signIn(User user) async {
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

    print(response.body);

    if (response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      final accessToken = responseBody['access_token'];
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', accessToken);
      return user;
    } else {
      throw Exception('Failed to create owner');
    }
  }
}

//   Future<User> signIn(User user) async {
//     print("here signing in");
//     final http.Response response = await http
//         .post(
//           headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
//           body: jsonEncode(<String, dynamic>{
//         'email': user.email,
//         'password': user.password,
//       }),
//           );
//     print(user.email);
//     print(user.password);
//     print(response.body);
//     if (response.statusCode == 201) {
//       final responseBody = json.decode(response.body);
//       final accessToken = responseBody['access_token'];
//       final prefs = await SharedPreferences.getInstance();

//       prefs.setString('access_token', accessToken);
//       return user;
//     } else {
//       throw Exception('Credentials not correct');
//     }
//   }
// }
