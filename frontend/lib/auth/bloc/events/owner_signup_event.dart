import 'package:equatable/equatable.dart';
import 'package:frontend/auth/models/auth.dart';

abstract class CompoundOwnerSignUpEvent extends Equatable {
  const CompoundOwnerSignUpEvent();

  @override
  List<Object> get props => [];
}

class OwnerSignUp extends CompoundOwnerSignUpEvent {
  final CompoundOwner owner;

  const OwnerSignUp({required this.owner});

  @override
  List<Object> get props => [owner];
}
