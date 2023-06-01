import 'package:frontend/auth/models/auth.dart';
import 'package:equatable/equatable.dart';


abstract class ReserverSignUpEvent extends Equatable {
  const ReserverSignUpEvent();
}

class ReserverSignUpLoad extends ReserverSignUpEvent {
  const ReserverSignUpLoad();

  @override
  List<Object> get props => [];
}

class ReserverSignUpFormInitalizedEvent extends ReserverSignUpEvent {
  const ReserverSignUpFormInitalizedEvent();

  @override
  List<Object> get props => [];
}

class ReserverSignUpButtonPressedEvent extends ReserverSignUpEvent {
  const ReserverSignUpButtonPressedEvent();

  @override
  List<Object> get props => [];
}

class ReserverSignUpEmailChangedEvent extends ReserverSignUpEvent {
  final String email;
  const ReserverSignUpEmailChangedEvent(this.email);

  @override
  List<Object> get props => [];
}

class ReserverSignUpPasswordChangedEvent extends ReserverSignUpEvent {
  final String password;
  const ReserverSignUpPasswordChangedEvent(this.password);

  @override
  List<Object> get props => [];
}

class ReserverSignUp extends ReserverSignUpEvent {
  final SpotReservingUser reserver;

  const ReserverSignUp({required this.reserver});

  @override
  List<Object> get props => [reserver];
}

class ReserverProfileUpdate extends ReserverSignUpEvent {
  final SpotReservingUser reserver;

  const ReserverProfileUpdate(this.reserver);

  @override
  List<Object> get props => [reserver];
}

class ReserverDelete extends ReserverSignUpEvent {
  final int user_id;

  const ReserverDelete(this.user_id);

  @override
  List<Object> get props => [user_id];

  @override
  toString() => 'Owner Deleted {owner Id: $user_id}';
}
