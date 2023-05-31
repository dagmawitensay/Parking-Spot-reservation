import 'package:equatable/equatable.dart';
import 'package:frontend/auth/models/auth.dart';

abstract class CompoundOwnerSignUpState extends Equatable {
  const CompoundOwnerSignUpState();

  @override
  List<Object> get props => [];
}

class OwnerSignUpInital extends CompoundOwnerSignUpState {}

class OwnerSignUpLoading extends CompoundOwnerSignUpState {}

class OwnerSignUpSucess extends CompoundOwnerSignUpState {
  final CompoundOwner owner;

  const OwnerSignUpSucess(this.owner);

  @override
  List<Object> get props => [owner];
}

class OwnerSignUpFailure extends CompoundOwnerSignUpState {
  final String errorMessage;

  const OwnerSignUpFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class OwnerSignUPSubmissionState extends CompoundOwnerSignUpState {}
