import 'package:equatable/equatable.dart';
import 'package:frontend/auth/models/auth.dart';

abstract class CompoundOwnerSignUpState extends Equatable {
  const CompoundOwnerSignUpState();

  List<Object> get props => [];
}

class SignUpInital extends CompoundOwnerSignUpState {}

class SignUpLoading extends CompoundOwnerSignUpState {}

class SignUpSucess extends CompoundOwnerSignUpState {
  final CompoundOwner owner;

  SignUpSucess(this.owner);

  @override
  List<Object> get props => [owner];
}

class SignUpFailure extends CompoundOwnerSignUpState {
  final String errorMessage;

  SignUpFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
