import 'package:equatable/equatable.dart';
import 'package:frontend/auth/models/auth.dart';

abstract class CompoundOwnerSignUpEvent extends Equatable {
  const CompoundOwnerSignUpEvent();
}

class OwnerSignUpLoad extends CompoundOwnerSignUpEvent {
  const OwnerSignUpLoad();

  @override
  List<Object> get props => [];
}

class OwnerSignUpFormInitalizedEvent extends CompoundOwnerSignUpEvent {
  const OwnerSignUpFormInitalizedEvent();

  @override
  List<Object> get props => [];
}

class OwnerSignUpButtonPressedEvent extends CompoundOwnerSignUpEvent {
  const OwnerSignUpButtonPressedEvent();

  @override
  List<Object> get props => [];
}

class OwnerSignUpEmailChangedEvent extends CompoundOwnerSignUpEvent {
  final String email;
  const OwnerSignUpEmailChangedEvent(this.email);

  @override
  List<Object> get props => [];
}

class OwnerSignUpPasswordChangedEvent extends CompoundOwnerSignUpEvent {
  final String password;
  const OwnerSignUpPasswordChangedEvent(this.password);

  @override
  List<Object> get props => [];
}

class OwnerSignUp extends CompoundOwnerSignUpEvent {
  final CompoundOwner owner;

  const OwnerSignUp({required this.owner});

  @override
  List<Object> get props => [owner];
}

class OwnerProfileUpdate extends CompoundOwnerSignUpEvent {
  final CompoundOwner owner;

  const OwnerProfileUpdate(this.owner);

  @override
  List<Object> get props => [owner];
}

class OwnerDelete extends CompoundOwnerSignUpEvent {
  final int owner_id;

  const OwnerDelete(this.owner_id);

  @override
  List<Object> get props => [owner_id];

  @override
  toString() => 'Owner Deleted {owner Id: $owner_id}';
}
