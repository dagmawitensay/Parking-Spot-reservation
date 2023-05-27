import 'package:flutter/material.dart';
import 'package:frontend/compounds/screens/screens.dart';
import 'package:go_router/go_router.dart';

import '../models/compound.dart';

final GoRouter appRoutes = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/parking-compounds',
    builder: (BuildContext context, GoRouterState state) {
      return CompoundList();
    },
    // routes: <RouteBase>[
    //   GoRoute(
    //       path: '/',
    //       builder: (context, state) {
    //         return AddUpdateCompound();
    //       })
    // ]
  ),
]);

class CompoundArgument {
  final Compound? compound;
  final bool edit;
  CompoundArgument({this.compound, required this.edit});
}
