import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'favorites.dart';
import 'home.dart';
import 'pet.dart';
import 'splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => Home(),
        '/pet': (context) => Pet(),
        '/favorites': (context) => Favorites(),
      },
    );
  }
}
