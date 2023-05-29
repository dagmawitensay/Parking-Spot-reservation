import 'package:flutter/material.dart';
import 'package:frontend/compounds/screens/screens.dart';
import 'package:go_router/go_router.dart';

import '../models/compound.dart';

class CompoundArgument {
  final Compound? compound;
  final bool edit;
  CompoundArgument({this.compound, required this.edit});
}
