import 'package:frontend/auth/data_provider/user_data_provider.dart';

import '../models/auth.dart';

class AuthRepository {
  final UserDataProvider userDataProvider;

  AuthRepository(this.userDataProvider);

  Future<CompoundOwner> signUpCompoundOwner(CompoundOwner owner) async {
    return this.userDataProvider.signUpCompoundOwner(owner);
  }

  Future<SpotReservingUser> signUPSpotReserver(
      SpotReservingUser reserver) async {
    return this.userDataProvider.signUpSpotReserver(reserver);
  }

  Future<User> signIn(User user) async {
    return this.userDataProvider.signIn(user);
  }
}
