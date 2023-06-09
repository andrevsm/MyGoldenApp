import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_golden/myColors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _images = [];
  List<String> favoriteImages = [];
  bool _isLoading = false;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference myFavoritesList;

  @override
  void initState() {
    super.initState();
    _loadImages();
    myFavoritesList = firestore.collection('favoriteImagesUrls');
    getFavoriteImages();
  }

  Future<void> _loadImages() async {
    if (_isLoading) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(Uri.parse(
        "https://dog.ceo/api/breed/retriever/golden/images/random/10"));
    final data = jsonDecode(response.body);
    List<String> images = List<String>.from(data['message']);
    setState(() {
      _images.addAll(images);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            color: MyColors.goldenDarkColor,
            onPressed: () {
              // Não fazer nada pois já está na Home
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // Navegar para a tela de Favoritos
              Navigator.pushNamed(context, '/favorites', arguments: {
                "listFavorites": favoriteImages,
              });
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
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!_isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                _loadImages();
              }
              return true;
            },
            child: GridView.builder(
                padding: const EdgeInsets.all(5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1,
                ),
                itemCount: _images.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/pet', arguments: {
                        'url': _images[index],
                      }).then((value) => addImages(_images[index]));
                    },
                    child: Image.network(
                      _images[index],
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
        ),
        _isLoading ? CircularProgressIndicator() : Container(),
      ],
    );
  }

  Future<void> getFavoriteImages() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference myFavoritesList = firestore.collection('favoriteImagesUrls');
    final DocumentSnapshot snapshot = await myFavoritesList.doc('urls').get();
    List<dynamic> list = snapshot.get('favoriteImages');
    favoriteImages = list.map((item) => item.toString()).toList();
  }


  Future<void> addImages(String imageUrl) async {
    if (!favoriteImages.contains(imageUrl)) {
      favoriteImages.add(imageUrl);
      await myFavoritesList.doc('urls').set({'favoriteImages' : favoriteImages});
    }
  }
}
