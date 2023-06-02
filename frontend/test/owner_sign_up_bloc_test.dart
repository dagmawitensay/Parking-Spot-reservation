import 'package:bloc_test/bloc_test.dart';
import 'package:frontend/';
import 'package:frontend/auth/bloc/events/owner_signup_event.dart';
import 'package:frontend/auth/bloc/states/owner_signup_state.dart';
import 'package:frontend/auth/repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late CompoundOwnerSignupBloc bloc;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    bloc = CompoundOwnerSignupBloc(authRepository: mockAuthRepository);
  });

  tearDown(() {
    bloc.close();
  });

  group('CompoundOwnerSignupBloc', () {
    final owner = Owner(/* provide necessary parameters */);

    test('initial state is OwnerSignUpInitial', () {
      expect(bloc.state, equals(OwnerSignUpInitial()));
    });

    blocTest<CompoundOwnerSignupBloc, CompoundOwnerSignUpEvent,
        CompoundOwnerSignUpState>(
      'emits OwnerSignUpInitial when OwnerSignUpFormInitializedEvent is added',
      build: () => bloc,
      act: (bloc) => bloc.add(OwnerSignUpFormInitializedEvent()),
      expect: () => [OwnerSignUpInitial()],
    );

    blocTest<CompoundOwnerSignupBloc, CompoundOwnerSignUpEvent,
        CompoundOwnerSignUpState>(
      'emits OwnerSignUpSubmissionState and OwnerSignUpSuccess when OwnerSignUp event is added and sign up is successful',
      build: () {
        when(mockAuthRepository.signUpCompoundOwner(owner))
            .thenAnswer((_) async => owner);
        return bloc;
      },
      act: (bloc) => bloc.add(OwnerSignUp(owner)),
      expect: () => [OwnerSignUpSubmissionState(), OwnerSignUpSuccess(owner)],
    );

    blocTest<CompoundOwnerSignupBloc, CompoundOwnerSignUpEvent,
        CompoundOwnerSignUpState>(
      'emits OwnerSignUpSubmissionState and OwnerSignUpFailure when OwnerSignUp event is added and sign up fails',
      build: () {
        when(mockAuthRepository.signUpCompoundOwner(owner))
            .thenThrow(Exception('Failed to sign up'));
        return bloc;
      },
      act: (bloc) => bloc.add(OwnerSignUp(owner)),
      expect: () => [
        OwnerSignUpSubmissionState(),
        const OwnerSignUpFailure('Failed to sign up')
      ],
    );
  });
}
