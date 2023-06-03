import 'package:equatable/equatable.dart';
import 'package:frontend/auth/models/auth.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInital extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSucess extends SignInState {
  final User user;

  const SignInSucess(this.user);

  @override
  List<Object> get props => [user];
}

class SignInFailure extends SignInState {
  final String errorMessage;

  const SignInFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class SignInSubmissionState extends SignInState {}

class AccountDeleteSuccess extends SignInState {}

class AccountDeleteFaliure extends SignInState {
  final String errorMessage;
  const AccountDeleteFaliure(this.errorMessage);
}
