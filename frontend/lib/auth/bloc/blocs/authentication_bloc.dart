import 'package:bloc/bloc.dart';
import 'package:frontend/auth/bloc/events/authentication_event.dart';
import 'package:frontend/auth/bloc/states/authenticatoin_state.dart';
import 'package:frontend/auth/models/auth.dart';
import 'package:frontend/auth/repository/auth_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;

  AuthenticationBloc({required this.authRepository})
      : super(AuthenticationUninitalized()) {
    on<AppStarted>((event, emit) async {
      final bool hasToken = await authRepository.hasToken();
      if (hasToken) {
        final token = await authRepository.getToken();
        final bool isValid = await authRepository.isValidToken(token!);
        if (isValid) {
          emit(AuthenticationAuthenticated(await authRepository.getRole()));
        } else {
          emit(AuthenticationUnauthenticated());
        }
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthenticationLoading());
      await authRepository.deleteToken();
      emit(AuthenticationUnauthenticated());
    });
  }
}
