import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/compounds/bloc/compound_bloc.dart';
import 'package:frontend/compounds/bloc/compound_event.dart';
import 'package:frontend/compounds/data_provider/compound_data_provider.dart';
import 'package:frontend/compounds/repository/compound_repository.dart';
import 'package:frontend/compounds/screens/compound_list.dart';
import 'package:frontend/reservation/screens/compound_list_for_user.dart';
import 'package:frontend/reservation/screens/routes.dart';
import 'package:frontend/reservation/screens/time_picker_page.dart';
import 'package:go_router/go_router.dart';

void main() {
  final CompoundRepository compoundRepository =
      CompoundRepository(CompoundDataProvider());
  runApp(MyApp(compoundRepository: compoundRepository));
}

class MyApp extends StatelessWidget {
  final CompoundRepository compoundRepository;
  const MyApp({required this.compoundRepository});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: compoundRepository,
      child: BlocProvider(
          create: (context) =>
              CompoundBloc(compoundRepository: compoundRepository)
                ..add(const CompoundLoad()),
          child: MaterialApp.router(
            title: 'Course App',
            routerConfig: _router,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
          )),
    );
  }
}

final _router = GoRouter(routes: [
  GoRoute(
    name: "home",
    path: '/',
    builder: (context, state) => CompoundListForUser(),
  ),
  GoRoute(
      name: 'timerPage',
      path: '/timer',
      builder: (context, state) {
        Object? compound_id = state.extra;
        // return DateTimePicker(compound_id: args.compound_id);
      })
]);
