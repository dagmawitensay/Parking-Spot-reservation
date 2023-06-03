import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:frontend/auth/bloc/reserver_signup_bloc.dart';
import 'package:frontend/auth/bloc/events/spot_reserver_signup_event.dart';
import 'package:frontend/auth/bloc/states/spot_reserver_signup_state.dart';
import 'package:frontend/repository/auth_repository.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('ReserverSignupBloc', () {
    late AuthRepository authRepository;
    late ReserverSignupBloc reserverSignupBloc;

    setUp(() {
      authRepository = MockAuthRepository();
      reserverSignupBloc = ReserverSignupBloc(authRepository: authRepository);
    });

    tearDown(() {
      reserverSignupBloc.close();
    });

    test('initial state is ReserverSignUpInital', () {
      expect(reserverSignupBloc.state, equals(ReserverSignUpInital()));
    });

    blocTest<ReserverSignupBloc, SpotReserverSignupState>(
      'emits ReserverSignUpInital when ReserverSignUpFormInitalizedEvent is added',
      build: () => reserverSignupBloc,
      act: (bloc) => bloc.add(const ReserverSignUpFormInitalizedEvent()),
      expect: () => [ReserverSignUpInital()],
    );

    blocTest<ReserverSignupBloc, SpotReserverSignupState>(
      'emits ReserverSignUPSubmissionState and ReserverSignUpSucess when ReserverSignUp event is added and sign-up is successful',
      build: () {
        when(authRepository.signUPSpotReserver(any))
            .thenAnswer((_) => Future.value('reserverId'));
        return reserverSignupBloc;
      },
      act: (bloc) => bloc.add(ReserverSignUp(reserver: Reserver())),
      expect: () => [
        ReserverSignUPSubmissionState(),
        ReserverSignUpSucess('reserverId'),
      ],
    );

    blocTest<ReserverSignupBloc, SpotReserverSignupState>(
      'emits ReserverSignUPSubmissionState and ReserverSignUpFailure when ReserverSignUp event is added and sign-up fails',
      build: () {
        when(authRepository.signUPSpotReserver(any))
            .thenThrow(Exception('Failed to sign up'));
        return reserverSignupBloc;
      },
      act: (bloc) => bloc.add(ReserverSignUp(reserver: Reserver())),
      expect: () => [
        ReserverSignUPSubmissionState(),
        ReserverSignUpFailure('Failed to sign up'),
      ],
    );
  });
}
