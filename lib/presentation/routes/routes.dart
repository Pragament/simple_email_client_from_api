import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pragament_mail/presentation/pages/email_viewer_page.dart';
import 'package:pragament_mail/presentation/pages/home_page.dart';
import 'package:pragament_mail/presentation/pages/login_page.dart';

part 'routes.g.dart';

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}

@TypedGoRoute<HomeRoute>(
  path: '/home',
  routes: [
    TypedGoRoute<EmailViewerPageRoute>(path: 'emailViewer/:emailId'),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

class EmailViewerPageRoute extends GoRouteData {
  const EmailViewerPageRoute({required this.emailId});
  final String emailId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EmailViewerPage(emailId: emailId);
  }
}
