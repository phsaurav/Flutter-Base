import 'package:flutter/material.dart';
import 'package:flutter_base/features/home/presentation/widget/home_screen.dart';
import 'package:go_router/go_router.dart';

/// The router for navigating between different screens in the app.
final GoRouter router = GoRouter(
  initialLocation: HomeScreen.routePath,
  routes: [
    GoRoute(
      path: HomeScreen.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    )
  ],
);
