import 'dart:async';
import 'package:flutter/material.dart';
import 'myColors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, '/home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/my_golden.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 100,
                alignment: Alignment.center,
                margin: EdgeInsetsDirectional.only(bottom: 30),
                decoration: BoxDecoration(
                  color: MyColors.goldenLightColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'My Golden App',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: MyColors.goldenDarkColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}