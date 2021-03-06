import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CatCard extends StatelessWidget {
  final String breed;
  final String imageUrl;
  final String description;
  const CatCard({this.breed, this.imageUrl, this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      shadowColor: Colors.black,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        splashColor: Colors.black12,
        onTap: () {},
        child: Column(
          children: <Widget>[
            CatImage(imageUrl: imageUrl, catId: breed),
            SizedBox(height: 20),
            BreedNameText(breed: breed),
            SizedBox(height: 10),
            PartialDescription(description: description),
          ],
        ),
      ),
    );
  }
}

class BreedNameText extends StatelessWidget {
  final String breed;
  BreedNameText({this.breed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          breed,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}

class CatImage extends StatefulWidget {
  final catId;
  final imageUrl;
  final double imageHeight = 250;
  final double imageWidth = 350;
  const CatImage({this.imageUrl, this.catId});

  @override
  _CatImageState createState() => _CatImageState();
}

class _CatImageState extends State<CatImage> {
  @override
  void initState() {
    super.initState();
  }

  var favoriteCatsBox = Hive.box('favorite_cats');

  Widget getIcon(String catId) {
    if (favoriteCatsBox.containsKey(catId)) {
      return (Icon(
        Icons.favorite,
        color: Colors.red,
        size: 30,
      ));
    }
    return (Icon(
      Icons.favorite_border,
      color: Colors.red,
      size: 30,
    ));
  }

  void onTapFavorite(String catId) {
    if (favoriteCatsBox.containsKey(catId)) {
      favoriteCatsBox.delete(catId);
      setState(() {
        getIcon(catId);
      });
    }
    else{
      favoriteCatsBox.put(catId, catId);
      setState(() {
        getIcon(catId);
      });
    }
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(
            widget.imageUrl,
            height: widget.imageHeight,
            width: widget.imageWidth,
            fit: BoxFit.fill,
            loadingBuilder: (context, child, progress) {
              return progress == null
                  ? child
                  : Container(
                      height: widget.imageHeight,
                      width: widget.imageWidth,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
            },
          ),
        ),
        new Positioned(
          top: 20.0,
          right: 25,
          child: InkWell(
              onTap: () => onTapFavorite(widget.catId),
              child: getIcon(widget.catId)),
        ),
      ]),
    );
  }
}

class PartialDescription extends StatelessWidget {
  final String description;
  PartialDescription({this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Description',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              description.substring(0, 50) + '...',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }
}
