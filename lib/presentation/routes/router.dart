import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pragament_mail/constants.dart';
import 'package:pragament_mail/data/settings.dart';
import 'package:pragament_mail/presentation/routes/routes.dart';

final routerProvider = Provider(
  (ref) {
    var loginState = ref.watch(loginStateNotifierProvider);

    return GoRouter(
      initialLocation: '/',
      routes: $appRoutes,
      redirect: (BuildContext context, GoRouterState state) {
        final bool isLoggedIn = loginState?['isLoggedIn'] ?? false;
        final DateTime? lastLogin = loginState?['timeStamp'];

        // If the user is not logged in and not on the Login screen, redirect to Login
        if (!isLoggedIn && state.uri.path != '/login') {
          return '/login';
        }

        if (lastLogin != null
            ? lastLogin
                .add(Duration(minutes: loginPeriod))
                .isBefore(DateTime.now())
            : !isLoggedIn && state.uri.path != '/login') {
          return '/login';
        }

        // If the user is logged in and on the Login screen, redirect to home
        if (isLoggedIn &&
            (state.uri.path == '/login' || state.uri.path == '/')) {
          return '/home';
        }

        // No redirect needed
        return null;
      },
    );
  },
);
