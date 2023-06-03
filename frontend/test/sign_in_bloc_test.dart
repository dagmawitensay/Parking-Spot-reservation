import 'package:bloc_test/bloc_test.dart';
import 'package:frontend/';
import 'package:frontend/auth/bloc/events/signin_event.dart';
import 'package:frontend/auth/bloc/states/signin_state.dart';
import 'package:frontend/auth/repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignInBloc bloc;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    bloc = SignInBloc(authRepository: mockAuthRepository);
  });

  tearDown(() {
    bloc.close();
  });

  group('SignInBloc', () {
    final user = User(/* provide necessary parameters */);

    test('initial state is SignInInitial', () {
      expect(bloc.state, equals(SignInInitial()));
    });

    blocTest<SignInBloc, SignInEvent, SignInState>(
      'emits SignInInitial when SignInFormInitializedEvent is added',
      build: () => bloc,
      act: (bloc) => bloc.add(SignInFormInitializedEvent()),
      expect: () => [SignInInitial()],
    );

    blocTest<SignInBloc, SignInEvent, SignInState>(
      'emits SignInSubmissionState and SignInSuccess when SignIn event is added and sign in is successful',
      build: () {
        when(mockAuthRepository.signIn(user)).thenAnswer((_) async => owner);
        return bloc;
      },
      act: (bloc) => bloc.add(SignIn(user)),
      expect: () => [SignInSubmissionState(), SignInSuccess(owner)],
    );

    blocTest<SignInBloc, SignInEvent, SignInState>(
      'emits SignInSubmissionState and SignInFailure when SignIn event is added and sign in fails',
      build: () {
        when(mockAuthRepository.signIn(user))
            .thenThrow(Exception('Failed to sign in'));
        return bloc;
      },
      act: (bloc) => bloc.add(SignIn(user)),
      expect: () =>
          [SignInSubmissionState(), const SignInFailure('Failed to sign in')],
    );
  });
}
