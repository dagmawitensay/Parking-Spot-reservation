import 'package:bloc/bloc.dart';
import 'package:frontend/auth/bloc/events/owner_signup_event.dart';
import 'package:frontend/auth/bloc/states/owner_signup_state.dart';
import 'package:frontend/auth/repository/auth_repository.dart';

class CompoundOwnerSignupBloc
    extends Bloc<CompoundOwnerSignUpEvent, CompoundOwnerSignUpState> {
  final AuthRepository authRepository;

  CompoundOwnerSignupBloc({required this.authRepository})
      : super(OwnerSignUpInital()) {
    on<OwnerSignUp>((event, emit) async {
      emit(OwnerSignUpLoading());
      try {
        final owner = await authRepository.signUpCompoundOwner(event.owner);
        emit(OwnerSignUpSucess(owner));
      } catch (error) {
        emit(const OwnerSignUpFailure("failed in here"));
      }
    });
  }
}
