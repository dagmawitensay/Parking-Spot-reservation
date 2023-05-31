import 'package:bloc/bloc.dart';
import 'package:frontend/auth/bloc/events/spot_reserver_signup_event.dart';
import 'package:frontend/auth/bloc/states/spot_reserver_signup_event.dart';
import '../../repository/auth_repository.dart';

class ReserverSignupBloc
    extends Bloc<ReserverSignUpEvent, SpotReserverSignupState> {
  final AuthRepository authRepository;

  ReserverSignupBloc({required this.authRepository})
      : super(ReserverSignUpInital()) {
    on<ReserverSignUpFormInitalizedEvent>((event, emit) async {
      emit(ReserverSignUpInital());
    });

    // on<OwnerSignUpEmailChangedEvent>((event, emit)async {
    //   final emailStatus = event.email;
    //   emit(Owner)
    // })
    on<ReserverSignUp>((event, emit) async {
      emit(ReserverSignUPSubmissionState());
      try {
        final reserver =
            await authRepository.signUPSpotReserver(event.reserver);
        emit(ReserverSignUpSucess(reserver));
      } catch (error) {
        emit(ReserverSignUpFailure(error.toString()));
      }
    });
  }
}
