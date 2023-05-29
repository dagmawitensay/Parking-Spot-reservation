import 'package:bloc/bloc.dart';
import 'package:frontend/auth/bloc/events/spot_reserver_signup_event.dart';
import 'package:frontend/auth/bloc/states/spot_reserver_signup_event.dart';

import '../../repository/auth_repository.dart';

class SpotReserverSignupBloc
    extends Bloc<SpotReserverSignupEvent, SpotReserverSignupState> {
  final AuthRepository authRepository;

  SpotReserverSignupBloc({required this.authRepository})
      : super(SignupInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoading());
      try {
        final reserver =
            await authRepository.signUPSpotReserver(event.reserver);
        emit(SignUpSuccess(reserver));
      } catch (error) {
        emit(SignUpFailure(error.toString()));
      }
    });
  }
}
