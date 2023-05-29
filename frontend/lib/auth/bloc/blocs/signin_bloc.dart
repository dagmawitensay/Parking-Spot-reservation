import 'package:bloc/bloc.dart';
import 'package:frontend/auth/bloc/events/signin_event.dart';
import 'package:frontend/auth/bloc/states/signin_state.dart';
import 'package:frontend/auth/repository/auth_repository.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository;

  SignInBloc({required this.authRepository}) : super(SignInInital()) {
    on<SignIn>((event, emit) async {
      emit(SignInLoading());
      try {
        final user = await authRepository.signIn(event.user);
        emit(SignInSucess(user));
      } catch (error) {
        emit(SignInFailure(error.toString()));
      }
    });
  }
}
