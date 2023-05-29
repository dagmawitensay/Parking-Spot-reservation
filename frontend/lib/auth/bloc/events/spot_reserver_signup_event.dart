import 'package:frontend/auth/models/auth.dart';
import 'package:equatable/equatable.dart';

abstract class SpotReserverSignupEvent extends Equatable {
  const SpotReserverSignupEvent();

  @override
  List<Object> get props => [];
}

class SignUpEvent extends SpotReserverSignupEvent {
  final SpotReservingUser reserver;

  const SignUpEvent({required this.reserver});

  @override
  List<Object> get props => [reserver];
}
