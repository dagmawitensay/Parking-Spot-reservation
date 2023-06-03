import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/auth/data_provider/user_data_provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../models/auth.dart';

class AuthRepository {
  final UserDataProvider userDataProvider;

  AuthRepository(this.userDataProvider);

  Future<CompoundOwner> signUpCompoundOwner(CompoundOwner owner) async {
    return userDataProvider.signUpCompoundOwner(owner);
  }

  Future<SpotReservingUser> signUPSpotReserver(
      SpotReservingUser reserver) async {
    return userDataProvider.signUpSpotReserver(reserver);
  }

  Future<User> signIn(User user) async {
    return userDataProvider.signIn(user);
  }

  Future<bool> isValidToken(String token) async {
    return userDataProvider.isValidToken(token);
  }

  Future<bool> hasToken() async {
    return userDataProvider.hasToken();
  }

  Future<String?> getToken() async {
    return userDataProvider.getToken();
  }

  Future<void> deleteToken() async {
    return userDataProvider.deleteToken();
  }

  Future<String> getRole() async {
    return userDataProvider.getRole();
  }

  Future<void> deleteAccount() async {
    await userDataProvider.deleteAccount();
  }
}
