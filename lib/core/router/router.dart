import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes_app/core/index.dart';
import 'package:recipes_app/features/index.dart';

enum RoutePath {
  root(path: '/'),
  inspirations(path: 'inspirations'),
  myRecipes(path: 'my_recipes'),
  cookNow(path: 'cook_now'),
  settings(path: 'settings');

  const RoutePath({required this.path});
  final String path;
}

final rootNavKey = GlobalKey<NavigatorState>(debugLabel: 'rootNav');
final shellNavInspirationsKey = GlobalKey<NavigatorState>(debugLabel: 'shellNavInspirationsKey');
final shellNavMyRecipesKey = GlobalKey<NavigatorState>(debugLabel: 'shellNavMyRecipesKey');
final shellNavCookNowKey = GlobalKey<NavigatorState>(debugLabel: 'shellNavCookNowKey');
final shellNavSettingsKey = GlobalKey<NavigatorState>(debugLabel: 'shellNavSettingsKey');

final router = GoRouter(
  navigatorKey: rootNavKey,
  redirect: (context, state) => routeRedirect(context, state),
  debugLogDiagnostics: true,
  routes: [
    // GoRoute(
    //     path: RoutePath.other.path,
    //     name: RoutePath.other.name,
    //     builder: (context, state) {
    //       return const OtherPage();
    //     },
    //     routes: []),

    GoRoute(
        path: RoutePath.root.path,
        name: RoutePath.root.name,
        builder: (context, state) => const LandingPage(),
        routes: [
          // GoRoute(
          //     path: RoutePath.other.path,
          //     name: RoutePath.other.name,
          //     builder: (context, state) {
          //       return const OtherPage();
          //     },
          //     routes: []),

          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return HomeNavWrapper(navigationShell: navigationShell);
            },
            branches: [
              CustomeStatefulShellBranch(
                'idea',
                navigatorKey: shellNavInspirationsKey,
                routes: [
                  GoRoute(
                      path: RoutePath.inspirations.path,
                      name: RoutePath.inspirations.name,
                      pageBuilder: (context, state) {
                        return MaterialPage(
                          key: state.pageKey,
                          child: const InspirationsPage(),
                        );
                      }),
                ],
              ),
              CustomeStatefulShellBranch(
                'todo_list',
                navigatorKey: shellNavMyRecipesKey,
                routes: [
                  GoRoute(
                      path: RoutePath.myRecipes.path,
                      name: RoutePath.myRecipes.name,
                      pageBuilder: (context, state) {
                        return MaterialPage(
                          key: state.pageKey,
                          child: const MyRecipesPage(),
                        );
                      }),
                ],
              ),
              CustomeStatefulShellBranch(
                'frying_pan',
                navigatorKey: shellNavCookNowKey,
                routes: [
                  GoRoute(
                      path: RoutePath.cookNow.path,
                      name: RoutePath.cookNow.name,
                      pageBuilder: (context, state) {
                        return MaterialPage(
                          key: state.pageKey,
                          child: const CookNowPage(),
                        );
                      }),
                ],
              ),
              CustomeStatefulShellBranch(
                'settings',
                navigatorKey: shellNavSettingsKey,
                routes: [
                  GoRoute(
                      path: RoutePath.settings.path,
                      name: RoutePath.settings.name,
                      pageBuilder: (context, state) {
                        return MaterialPage(
                          key: state.pageKey,
                          child: const SettingsPage(),
                        );
                      }),
                ],
              ),
            ],
          ),
        ]),
  ],
);

mixin ExtraParams {
  String get assetName;
}

class CustomeStatefulShellBranch extends StatefulShellBranch {
  final String assetName;
  CustomeStatefulShellBranch(this.assetName,
      {required super.routes, required GlobalKey<NavigatorState> navigatorKey});
}
