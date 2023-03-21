import 'package:flutter/material.dart';
import 'myColors.dart';

class Pet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    bool favorite = false;

    final String imageUrl = args['url'];
    if (null != args['favorite']) {
      favorite = args['favorite'];
    }

    return Scaffold(
      backgroundColor: MyColors.goldenLightColor,
      appBar: AppBar(
        title: const Text(
          'My Golden App',
          style: TextStyle(
            color: MyColors.goldenDarkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: MyColors.goldenColor,
      ),
      body: Column(
        children: [
          Container(
            child: Container(
              height: 500,
              width: double.infinity,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    'assets/images/my_golden.jpeg',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.only(start: 100, end: 100),
            margin: EdgeInsetsDirectional.only(top: 20),
            decoration: BoxDecoration(
              color: MyColors.goldenColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: TextButton(
              onPressed: () {
                // handle button press here
                Navigator.pop(context, imageUrl);
              },
              child: const Text(
                'LIKE!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: MyColors.goldenDarkColor
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
