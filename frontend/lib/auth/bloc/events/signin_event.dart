import 'package:equatable/equatable.dart';

import '../../models/auth.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

class SignInLoad extends SignInEvent {
  const SignInLoad();

  @override
  List<Object> get props => [];
}

class SignInFormInitalizedEvent extends SignInEvent {
  const SignInFormInitalizedEvent();

  @override
  List<Object> get props => [];
}

class SignInButtonPressedEvent extends SignInEvent {
  const SignInButtonPressedEvent();

  @override
  List<Object> get props => [];
}

class SignInEmailChangedEvent extends SignInEvent {
  final String email;
  const SignInEmailChangedEvent(this.email);

  @override
  List<Object> get props => [];
}

class SignInPasswordChangedEvent extends SignInEvent {
  final String password;
  const SignInPasswordChangedEvent(this.password);

  @override
  List<Object> get props => [];
}

class SignIn extends SignInEvent {
  final User user;

  const SignIn({required this.user});

  @override
  List<Object> get props => [user];
}

class AccountDelete extends SignInEvent {
  const AccountDelete();
  @override
  List<Object> get props => [];
}
