import 'package:equatable/equatable.dart';
import 'package:frontend/auth/bloc/events/spot_reserver_signup_event.dart';
import 'package:frontend/auth/models/auth.dart';

abstract class SpotReserverSignupState extends Equatable {
  const SpotReserverSignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SpotReserverSignupState {}

class SignUpLoading extends SpotReserverSignupState {}

class SignUpSuccess extends SpotReserverSignupState {
  final SpotReservingUser reserver;

  const SignUpSuccess(this.reserver);

  @override
  List<Object> get props => [reserver];
}

class SignUpFailure extends SpotReserverSignupState {
  final String errorMessage;

  const SignUpFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
