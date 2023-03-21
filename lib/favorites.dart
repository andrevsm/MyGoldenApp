import 'package:flutter/material.dart';
import 'package:my_golden/myColors.dart';

class Favorites extends StatelessWidget {
  late List<String> favoriteImages;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    favoriteImages = args['listFavorites'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            style: TextStyle(
                color: MyColors.goldenDarkColor, fontWeight: FontWeight.bold),
            'My Golden App'),
        backgroundColor: MyColors.goldenColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // Retornar para home
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            color: MyColors.goldenDarkColor,
            onPressed: () {
              // Não fazer nada pois já está na Home
            },
          ),
        ],
      ),
      body: _buildBody(),
      backgroundColor: MyColors.goldenLightColor,
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.all(5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1,
                ),
                itemCount: favoriteImages.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/pet', arguments: {
                        'url': favoriteImages[index],
                        'favorite': true,
                      });
                    },
                    child: Image.network(
                      favoriteImages[index],
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.asset('assets/images/my_golden.jpeg',
                            fit: BoxFit.cover);
                      },
                    ),
                  );
                }),
          ),
      ],
    );
  }
}