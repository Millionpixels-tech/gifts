import 'package:gifts/router/router_names.dart';
import 'package:gifts/screens/Tracking_page.dart';
import 'package:gifts/screens/address_details.dart';
import 'package:gifts/screens/auth/login_page.dart';
import 'package:gifts/screens/auth/signup_page.dart';
import 'package:gifts/screens/congratulations_page.dart';
import 'package:gifts/screens/home_page.dart';
import 'package:gifts/screens/pick_box_page.dart';
import 'package:go_router/go_router.dart';

class RouterClass{
  final router = GoRouter(
    initialLocation: "/home",
    routes: [
      GoRoute(path: "/home",
      name: RouterNames.login,
      pageBuilder: (context, state) {
          return NoTransitionPage(
              child: const CongratulationsPage(),
          );
        },
      ),
      GoRoute(path: "/signup",
      name: RouterNames.signup,
      pageBuilder: (context, state) {
          return NoTransitionPage(
              child: const SignupPage(),
          );
        },
      )
    ]
  );
}

class NoTransitionPage<T> extends CustomTransitionPage<T> {
  NoTransitionPage({required super.child})
      : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );
}