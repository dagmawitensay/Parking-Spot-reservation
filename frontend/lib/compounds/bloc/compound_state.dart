import 'package:equatable/equatable.dart';

import '../models/compound.dart';

abstract class CompoundState extends Equatable {
  const CompoundState();

  @override
  List<Object> get props => [];
}

class CompoundLoading extends CompoundState {}

class CompoundOperationSuccess extends CompoundState {
  final List<Compound> compounds;

  const CompoundOperationSuccess([this.compounds = const []]);

  @override
  List<Object> get props => [compounds];
}

class CompoundOperationFailure extends CompoundState {
  final Object error;

  const CompoundOperationFailure(this.error);

  @override
  List<Object> get pops => [error];
}
