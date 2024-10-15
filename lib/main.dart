import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gifts/firebase_options.dart';
import 'package:gifts/router/router.dart';
import 'package:gifts/utils/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await _clearSharedPreferences();
  if (kIsWeb) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  } else {
    await Firebase.initializeApp();
  }
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

Future<void> _clearSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();  // Clear all stored preferences
}