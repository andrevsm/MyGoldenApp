import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final List<String> favoriteImages = args['listFavorites'];
    return const Scaffold(

    );
  }

}