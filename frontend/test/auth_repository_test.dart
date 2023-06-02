import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/auth/data_provider/user_data_provider.dart';
import 'package:frontend/auth/models/auth.dart';
import 'package:frontend/auth/repository/auth_repository.dart';
import 'package:mockito/mockito.dart';

class MockUserDataProvider extends Mock implements UserDataProvider {}

void main() {
  late AuthRepository repository;
  late MockUserDataProvider mockUserDataProvider;

  setUp(() {
    mockUserDataProvider = MockUserDataProvider();
    repository = AuthRepository(mockUserDataProvider);
  });

  group('AuthRepository', () {
    test('calls signUpCompoundOwner method in UserDataProvider', () async {
      final owner = CompoundOwner(
          email: '',
          firstName: '',
          password: '',
          lastName: '',
          username: '' /* provide necessary parameters */);
      when(mockUserDataProvider.signUpCompoundOwner(owner))
          .thenAnswer((_) async => owner);

      final result = await repository.signUpCompoundOwner(owner);

      verify(mockUserDataProvider.signUpCompoundOwner(owner)).called(1);
      expect(result, equals(owner));
    });

    test('calls signUpSpotReserver method in UserDataProvider', () async {
      final reserver = SpotReservingUser(
          email: '',
          id: 89,
          firstName: '',
          lastName: '',
          password: '',
          username: '' /* provide necessary parameters */);
      when(mockUserDataProvider.signUpSpotReserver(reserver))
          .thenAnswer((_) async => reserver);

      final result = await repository.signUPSpotReserver(reserver);

      verify(mockUserDataProvider.signUpSpotReserver(reserver)).called(1);
      expect(result, equals(reserver));
    });

    test('calls signIn method in UserDataProvider', () async {
      final user =
          User(email: '', password: '' /* provide necessary parameters */);
      when(mockUserDataProvider.signIn(user)).thenAnswer((_) async => user);

      final result = await repository.signIn(user);

      verify(mockUserDataProvider.signIn(user)).called(1);
      expect(result, equals(user));
    });

    test('calls isValidToken method in UserDataProvider', () async {
      const token = 'example_token';
      when(mockUserDataProvider.isValidToken(token))
          .thenAnswer((_) async => true);

      final result = await repository.isValidToken(token);

      verify(mockUserDataProvider.isValidToken(token)).called(1);
      expect(result, isTrue);
    });

    test('calls hasToken method in UserDataProvider', () async {
      when(mockUserDataProvider.hasToken()).thenAnswer((_) async => true);

      final result = await repository.hasToken();

      verify(mockUserDataProvider.hasToken()).called(1);
      expect(result, isTrue);
    });

    test('calls getToken method in UserDataProvider', () async {
      const token = 'example_token';
      when(mockUserDataProvider.getToken()).thenAnswer((_) async => token);

      final result = await repository.getToken();

      verify(mockUserDataProvider.getToken()).called(1);
      expect(result, equals(token));
    });

    test('calls deleteToken method in UserDataProvider', () async {
      await repository.deleteToken();

      verify(mockUserDataProvider.deleteToken()).called(1);
    });
  });
}
