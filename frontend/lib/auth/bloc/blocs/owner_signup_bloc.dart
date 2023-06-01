import 'package:bloc/bloc.dart';
import 'package:frontend/auth/bloc/events/owner_signup_event.dart';
import 'package:frontend/auth/bloc/states/owner_signup_state.dart';
import 'package:frontend/auth/repository/auth_repository.dart';

class CompoundOwnerSignupBloc
    extends Bloc<CompoundOwnerSignUpEvent, CompoundOwnerSignUpState> {
  final AuthRepository authRepository;

  CompoundOwnerSignupBloc({required this.authRepository})
      : super(OwnerSignUpInital()) {
    on<OwnerSignUpFormInitalizedEvent>((event, emit) async {
      print('Owner signUp initalizing');
      emit(OwnerSignUpInital());
    });

    // on<OwnerSignUpEmailChangedEvent>((event, emit)async {
    //   final emailStatus = event.email;
    //   emit(Owner)
    // })
    on<OwnerSignUp>((event, emit) async {
      emit(OwnerSignUPSubmissionState());
      try {
        final owner = await authRepository.signUpCompoundOwner(event.owner);
        emit(OwnerSignUpSucess(owner));
      } catch (error) {
        emit(OwnerSignUpFailure(error.toString()));
      }
    });
  }
}
