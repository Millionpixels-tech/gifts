import 'package:flutter/material.dart';
import 'package:gifts/router/router.dart';
import 'package:gifts/utils/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Gifts',
      theme: appLightTheme,
      routerConfig: RouterClass().router,
    );
  }
}