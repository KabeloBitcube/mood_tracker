import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/Home/home.dart';

void main() {
  runApp(const MyApp());
}

// Go router navigation
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen()
    ),
  ]
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

