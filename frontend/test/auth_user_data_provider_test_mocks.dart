import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:frontend/';
import 'package:frontend/auth/models/auth.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('UserDataProvider', () {
    late UserDataProvider userDataProvider;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      userDataProvider = UserDataProvider(client: mockClient);
    });

    test('signUpCompoundOwner returns a CompoundOwner', () async {
      final owner = CompoundOwner(
        username: 'testuser',
        email: 'testemail@test.com',
        password: 'testpassword',
        firstName: 'Test',
        lastName: 'User',
      );

      when(mockClient.post(
        Uri.parse('http://localhost:3000/auth/owner/signup'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
          '{"access_token":"test_token"}', 201));

      final result = await userDataProvider.signUpCompoundOwner(owner);

      expect(result, isA<CompoundOwner>());
      expect(result.username, equals(owner.username));
      expect(result.email, equals(owner.email));
      expect(result.password, equals(owner.password));
      expect(result.firstName, equals(owner.firstName));
      expect(result.lastName, equals(owner.lastName));
    });

    test('signUpSpotReserver returns a SpotReservingUser', () async {
      final reserver = SpotReservingUser(
        username: 'testuser',
        email: 'testemail@test.com',
        password: 'testpassword',
        firstName: 'Test',
        lastName: 'User',
      );

      when(mockClient.post(
        Uri.parse('http://localhost:3000/auth/parker/signup'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
          '{"access_token":"test_token"}', 201));

      final result = await userDataProvider.signUpSpotReserver(reserver);

      expect(result, isA<SpotReservingUser>());
      expect(result.username, equals(reserver.username));
      expect(result.email, equals(reserver.email));
      expect(result.password, equals(reserver.password));
      expect(result.firstName, equals(reserver.firstName));
      expect(result.lastName, equals(reserver.lastName));
    });

    test('signIn returns a User', () async {
      final user = User(
        email: 'testemail@test.com',
        password: 'testpassword',
      );

      when(mockClient.post(
        Uri.parse('http://localhost:3000/auth/signin'),
        headers: anyNamed('headers'),
        body: anyNamed('bodyGreat! Here's the rest of the code for the `userDataProvider` unit test:

      )).thenAnswer((_) async => http.Response(
          '{"access_token":"test_token"}', 201));

      final result = await userDataProvider.signIn(user);

      expect(result, isA<User>());
      expect(result.email, equals(user.email));
      expect(result.password, equals(user.password));
    });

    test('isValidToken returns true for a valid token', () async {
      const token = 'valid_token';

      when(mockClient.get(
        Uri.parse('http://localhost:3000/auth/validate'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('{"valid":true}', 200));

      final result = await userDataProvider.isValidToken(token);

      expect(result, equals(true));
    });

    test('hasToken returns true if a token exists', () async {
      when(userDataProvider.storage.read(key: 'token'))
          .thenAnswer((_) async => 'test_token');

      final result = await userDataProvider.hasToken();

      expect(result, equals(true));
    });

    test('getToken returns the stored token', () async {
      when(userDataProvider.storage.read(key: 'token'))
          .thenAnswer((_) async => 'test_token');

      final result = await userDataProvider.getToken();

      expect(result, equals('test_token'));
    });

    test('persitstToken stores the token in secure storage', () async {
test('persitstToken stores the token in secure storage', () async {
  await userDataProvider.persitstToken('test_token');

  verify(userDataProvider.storage.write(key: 'token', value: 'test_token'))
      .called(1);
});

test('deleteToken deletes the token from secure storage', () async {
  await userDataProvider.deleteToken();

  verify(userDataProvider.storage.deleteAll()).called(1);
});
});
}