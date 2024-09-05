import 'package:gifts/router/router_names.dart';
import 'package:gifts/screens/Tracking_page.dart';
import 'package:gifts/screens/address_details.dart';
import 'package:gifts/screens/auth/login_page.dart';
import 'package:gifts/screens/auth/signup_page.dart';
import 'package:gifts/screens/congratulations_page.dart';
import 'package:gifts/screens/home_page.dart';
import 'package:gifts/screens/pick_box_page.dart';
import 'package:gifts/screens/your_rewards_page.dart';
import 'package:go_router/go_router.dart';

class RouterClass {
  final router = GoRouter(initialLocation: "/home", routes: [
    GoRoute(
      path: "/home",
      name: RouterNames.login,
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: const HomePage(),
        );
      },
    ),
    GoRoute(
      path: "/signup",
      name: RouterNames.signup,
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: const SignupPage(),
        );
      },
    ),
    GoRoute(
      path: "/homepage",
      name: RouterNames.homepage,
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: const HomePage(),
        );
      },
    ),
    GoRoute(
      path: "/addressdetails",
      name: RouterNames.addressdetails,
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: const AddressDetails(),
        );
      },
    ),
    GoRoute(
      path: "/congratulationspage",
      name: RouterNames.congratulationspage,
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: const CongratulationsPage(),
        );
      },
    ),
    GoRoute(
      path: "/pickbox",
      name: RouterNames.pickbox,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?; // Use nullable type
        final itemName = extra?['itemName'] as String? ??
            'Default Item'; // Provide default values if null
        final currentBox =
            extra?['currentBox'] as int? ?? 1; // Provide default values if null
        return NoTransitionPage(
          child: PickBoxPage(
            itemName: itemName,
            currentBox: currentBox,
          ),
        );
      },
    ),
    GoRoute(
      path: "/trackingpage",
      name: RouterNames.trackingpage,
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: const TrackingPage(
            currentStep: 1,
          ),
        );
      },
    ),
    GoRoute(
      path: "/yourrewards",
      name: RouterNames.yourrewards,
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: const YourRewardsPage(),
        );
      },
    ),
  ]);
}

class NoTransitionPage<T> extends CustomTransitionPage<T> {
  NoTransitionPage({required super.child})
      : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );
}
