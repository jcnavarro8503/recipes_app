import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes_app/core/index.dart';

FutureOr<String?> routeRedirect(BuildContext context, GoRouterState state) async {
  // check auth block state
  final user = {"name": 'jhon'};
  final logginOut = user == null && state.matchedLocation == RoutePath.root.path;
  final loggedIn = user != null;
  final loggingIn = state.matchedLocation == RoutePath.root.path;

  if (logginOut) return RoutePath.root.path;
  if (loggedIn && loggingIn) return RoutePath.root.path;

  return null;
}
