import 'package:bloc/bloc.dart';
import 'package:frontend/auth/bloc/events/authentication_event.dart';
import 'package:frontend/auth/bloc/states/authenticatoin_state.dart';
import 'package:frontend/auth/models/auth.dart';
import 'package:frontend/auth/repository/auth_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;

  AuthenticationBloc({required this.authRepository})
      : super(AutenticationInital()) {
    on<AuthenticationStarted>((event, emit) {
      emit(AutenticationInital());
    });

    on<AuthenticationLoggedIn>((event, emit) {
      final user = event.user;
      if (user is CompoundOwner) {
        emit(OwnerAuthenticated(user));
      } else if (user is SpotReservingUser) {
        emit(ReserverAuthenticated(user));
      } else {
        emit(const AuthenticatoinFailure('Unkown user'));
      }
    });

    on<AuthenticationLoggedOut>((event, emit) {
      emit(AutenticationInital());
    });
  }
}
