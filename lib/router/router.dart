import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gifts/blocs/auth/auth_bloc.dart';
import 'package:gifts/blocs/product/product_bloc.dart';
import 'package:gifts/router/router_names.dart';
import 'package:gifts/screens/Tracking_page.dart';
import 'package:gifts/screens/address_details.dart';
import 'package:gifts/screens/auth/register_page.dart';
import 'package:gifts/screens/auth/login_page.dart';
import 'package:gifts/screens/congratulations_page.dart';
import 'package:gifts/screens/home_page.dart';
import 'package:gifts/screens/pick_box_page.dart';
import 'package:gifts/screens/your_rewards_page.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class RouterClass {
  final router = GoRouter(
      initialLocation: "/home",
      errorPageBuilder: (context, state) {
        return const MaterialPage<dynamic>(
          child: Scaffold(
            body: Center(
              child: Text('This Page is Not Found!'),
            ),
          ),
        );
      },
      routes: [
        GoRoute(
          path: "/home",
          name: RouterNames.home,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => AuthBloc(),
                  ),
                  BlocProvider(
                    create: (context) => ProductBloc(),
                  ),
                ],
                child: const HomePage(),
              ),
            );
          },
        ),
        GoRoute(
          path: "/register",
          name: RouterNames.register,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: BlocProvider(
                create: (context) => AuthBloc(),
                child: const RegisterPage(),
              ),
            );
          },
        ),
        GoRoute(
          path: "/login",
          name: RouterNames.login,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: BlocProvider(
                create: (context) => AuthBloc(),
                child: const LoginPage(),
              ),
            );
          },
        ),
        GoRoute(
          path: "/addressdetails",
          name: RouterNames.addressdetails,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: BlocProvider(
                create: (context) => AuthBloc(),
                child: const AddressDetails(),
              ),
            );
          },
        ),
        GoRoute(
          path: "/congratulationspage",
          name: RouterNames.congratulationspage,
          pageBuilder: (context, state) {
            final extra =
                state.extra as Map<String, dynamic>?; // Use nullable type
            final itemImageUrl = extra?['itemImageUrl'] as String? ??
                'Default Item';
            return NoTransitionPage(
              child: CongratulationsPage(itemImageUrl: itemImageUrl,),
            );
          },
        ),
        GoRoute(
          path: "/pickbox",
          name: RouterNames.pickbox,
          pageBuilder: (context, state) {
            final extra =
                state.extra as Map<String, dynamic>?; // Use nullable type
            final itemName = extra?['itemName'] as String? ??
                'Default Item'; // Provide default values if null
                final itemImageUrl = extra?['itemImageUrl'] as String? ??
                ' ';
            final currentBox = extra?['currentBox'] as int? ??
                1; // Provide default values if null
            return NoTransitionPage(
              child: PickBoxPage(
                itemName: itemName,
                currentBox: currentBox,
                itemImageUrl: itemImageUrl,
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
