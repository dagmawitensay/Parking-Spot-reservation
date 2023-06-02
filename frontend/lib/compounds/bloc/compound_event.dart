import 'package:equatable/equatable.dart';

import '../models/compound.dart';

abstract class CompoundEvent extends Equatable {
  const CompoundEvent();
}

class CompoundCreate extends CompoundEvent {
  final Compound compound;

  const CompoundCreate(this.compound);

  @override
  List<Object> get props => [compound];

  @override
  String toString() => 'Compound Created {compound: ${compound.id}}';
}

class CompoundLoad extends CompoundEvent {
  const CompoundLoad();

  @override
  List<Object> get props => [];
}

class CompoundUpdate extends CompoundEvent {
  final Compound compound;

  const CompoundUpdate(this.compound);

  @override
  List<Object> get props => [Compound];

  @override
  String toString() => 'Compound Updated {compound: ${compound.id}}';
}


class CompoundDelete extends CompoundEvent {
  final int id;

  
  const CompoundDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Compound Deleted {compound Id: $id}';
}
