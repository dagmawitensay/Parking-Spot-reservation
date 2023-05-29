import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRoutes = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
            path: 'details',
            builder: (BuildContext context, GoRouterState state) {
              return DetailScreen();
            })
      ])
]);

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home screen')),
        body: Center(
          child: ElevatedButton(
            child: Text('Next'),
            onPressed: () {},
          ),
        ));
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Detail Screen')),
        body: Center(
            child: ElevatedButton(
          child: Text('Back'),
          onPressed: () {},
        )));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRoutes,
    );
  }
}

void main() => runApp(MyApp());
