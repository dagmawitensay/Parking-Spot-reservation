import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_event.dart';
import 'package:frontend/compounds/data_provider/compound_data_provider.dart';
import 'package:frontend/compounds/repository/compound_repository.dart';
import 'package:frontend/compounds/screens/compound_add_update.dart';
import 'package:frontend/compounds/screens/compound_list.dart';
import 'package:frontend/compounds/screens/compound_route.dart';
import 'package:go_router/go_router.dart';
import 'compounds/bloc/compound_bloc.dart';
import 'compounds/bloc_observer.dart';
import 'compounds/data_provider/compound_local_data_provider.dart';
import 'localDatabase/connectivity_checking.dart';
import 'sync_manager/syncing.dart';

void main() {
  SyncManager      syncManager = SyncManager();
  CompoundDataProvider dataProvider = CompoundDataProvider();
  CompoundLocalDataProvider localProvider = CompoundLocalDataProvider();
  ConnectivityChecks  connectivitychecker = ConnectivityChecks();
  final CompoundRepository compoundRepository =
      CompoundRepository(dataProvider, localProvider,connectivitychecker);

  Bloc.observer = MyBlocObserver();
  syncManager.syncingManager();
  runApp(CompoundApp(compoundRepository: compoundRepository));
}

// ignore: must_be_immutable
class CompoundApp extends StatelessWidget {
  CompoundRepository compoundRepository;P

  CompoundApp({required this.compoundRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: this.compoundRepository,
        child: BlocProvider(
            create: (context) =>
                CompoundBloc(compoundRepository: compoundRepository)
                  ..add(CompoundLoad()),
            child: MaterialApp.router(
              title: 'Compound App',
              routerDelegate: _router.routerDelegate,
              routeInformationParser: _router.routeInformationParser,
              routeInformationProvider: _router.routeInformationProvider,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
            )));
  }

  final GoRouter _router = GoRouter(routes: <GoRoute>[
    GoRoute(
        path: '/',
        builder: (context, state) => CompoundList(),
        routes: <GoRoute>[
          GoRoute(
              path: 'addUpdateCompound',
              builder: (context, state) {
                CompoundArgument args = state.extra as CompoundArgument;
                return AddUpdateCompound(args: args);
              })
        ])
  ]);
}
