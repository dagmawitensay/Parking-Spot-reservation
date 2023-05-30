import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRoutes = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
            path: 'details',
            builder: (BuildContext context, GoRouterState state) {
              return const DetailScreen();
            })
      ])
]);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home screen')),
        body: Center(
          child: ElevatedButton(
            child: const Text('Next'),
            onPressed: () {},
          ),
        ));
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Detail Screen')),
        body: Center(
            child: ElevatedButton(
          child: const Text('Back'),
          onPressed: () {},
        )));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRoutes,
    );
  }
}

void main() => runApp(const MyApp());
