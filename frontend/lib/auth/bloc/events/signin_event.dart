import 'package:equatable/equatable.dart';

import '../../models/auth.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignIn extends SignInEvent {
  final User user;
  const SignIn({required this.user});

  @override
  List<Object> get props => [user];
}
