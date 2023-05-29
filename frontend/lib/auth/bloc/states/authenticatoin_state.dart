import 'package:equatable/equatable.dart';
import 'package:frontend/auth/models/auth.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AutenticationInital extends AuthenticationState {}

class OwnerAuthenticated extends AuthenticationState {
  final CompoundOwner owner;

  const OwnerAuthenticated(this.owner);

  @override
  List<Object> get props => [owner];
}

class ReserverAuthenticated extends AuthenticationState {
  final SpotReservingUser reserver;
  const ReserverAuthenticated(this.reserver);

  @override
  List<Object> get props => [reserver];
}

class AuthenticatoinFailure extends AuthenticationState {
  final String errorMessage;

  const AuthenticatoinFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
