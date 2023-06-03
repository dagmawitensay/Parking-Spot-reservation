import 'package:equatable/equatable.dart';

import '../../models/auth.dart';

abstract class SpotReserverSignupState extends Equatable {
  const SpotReserverSignupState();

  @override
  List<Object> get props => [];
}

class ReserverSignUpInital extends SpotReserverSignupState {}

class ReserverSignUpLoading extends SpotReserverSignupState {}

class ReserverSignUpSucess extends SpotReserverSignupState {
  final SpotReservingUser reserver;

  const ReserverSignUpSucess(this.reserver);

  @override
  List<Object> get props => [reserver];
}

class ReserverSignUpFailure extends SpotReserverSignupState {
  final String errorMessage;

  const ReserverSignUpFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class ReserverSignUPSubmissionState extends SpotReserverSignupState {}
