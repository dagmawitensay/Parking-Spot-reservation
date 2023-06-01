import 'package:frontend/auth/data_provider/user_data_provider.dart';

import '../models/auth.dart';

class AuthRepository {
  final UserDataProvider userDataProvider;

  AuthRepository(this.userDataProvider);

  Future<CompoundOwner> signUpCompoundOwner(CompoundOwner owner) async {
    print(userDataProvider);
    return userDataProvider.signUpCompoundOwner(owner);
  }

  Future<SpotReservingUser> signUPSpotReserver(
      SpotReservingUser reserver) async {
    return userDataProvider.signUpSpotReserver(reserver);
  }

  Future<User> signIn(User user) async {
    return userDataProvider.signIn(user);
  }
}
