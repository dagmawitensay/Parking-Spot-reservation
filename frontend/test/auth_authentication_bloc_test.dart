import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/';
import 'package:frontend/auth/bloc/events/authentication_event.dart';
import 'package:frontend/auth/bloc/states/authenticatoin_state.dart';
import 'package:frontend/auth/repository/auth_repository.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('AuthenticationBloc', () {
    late AuthenticationBloc authenticationBloc;
    late AuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      authenticationBloc = AuthenticationBloc(authRepository: mockAuthRepository);
    });

    tearDown(() {
      authenticationBloc.close();
    });

    test('initial state is AuthenticationUninitalized', () {
      expect(authenticationBloc.state, equals(AuthenticationUninitalized()));
    });

    test('emits AuthenticationAuthenticated if token is valid', () async {
      const token = 'valid_token';

      when(mockAuthRepository.hasToken()).thenAnswer((_) async => true);
      when(mockAuthRepository.getToken()).thenAnswer((_) async => token);
      when(mockAuthRepository.isValidToken(token)).thenAnswer((_) async => true);

      authenticationBloc.add(AppStarted());

      await expectLater(
        authenticationBloc,
        emitsInOrder([AuthenticationAuthenticated()]),
     ]);

      verify(mockAuthRepository.hasToken()).called(1);
      verify(mockAuthRepository.getToken()).called(1);
      verify(mockAuthRepository.isValidToken(token)).called(1);
    });

    test('emits AuthenticationUnauthenticated if token is invalid', () async {
      const token = 'invalid_token';

      when(mockAuthRepository.hasToken()).thenAnswer((_) async => true);
      when(mockAuthRepository.getToken()).thenAnswer((_) async => token);
      when(mockAuthRepository.isValidToken(token)).thenAnswer((_) async => false);

      authenticationBloc.add(AppStarted());

      await expectLater(
        authenticationBloc,
        emitsInOrder([AuthenticationUnauthenticated()]),
      );

      verify(mockAuthRepository.hasToken()).called(1);
      verify(mockAuthRepository.getToken()).called(1);
      verify(mockAuthRepository.isValidToken(token)).called(1);
    });

    test('emits AuthenticationUnauthenticated if no token exists', () async {
      when(mockAuthRepository.hasToken()).thenAnswer((_) async => false);

      authenticationBloc.add(AppStarted());

      await expectLater(
        authenticationBloc,
        emitsInOrder([AuthenticationUnauthenticated()]),
      );

      verify(mockAuthRepository.hasToken()).called(1);
    });

    test('emits AuthenticationUnauthenticated after LoggedOut event', () async {
      authenticationBloc.add(LoggedOut());

      await expectLater(
        authenticationBloc,
        emitsInOrder([AuthenticationLoading(), AuthenticationUnauthenticated()]),
      );

     verify(mockAuthRepository.deleteToken()).called(1);
    });
  });
}