import 'package:equatable/equatable.dart';

class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitalized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final String role;

  AuthenticationAuthenticated(this.role);
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
