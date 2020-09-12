import 'dart:ui';

import 'package:flutter/material.dart';

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
            CatImage(imageUrl: imageUrl),
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

class CatImage extends StatelessWidget {
  final imageUrl;
  final double imageHeight = 250;
  final double imageWidth = 310;
  const CatImage({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          imageUrl,
          height: imageHeight,
          width: imageWidth,
          fit: BoxFit.fill,
          loadingBuilder: (contex, child, progress) {
            return progress == null
                ? child
                : Container(
                    height: imageHeight,
                    width: imageWidth,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
          },
        ),
      ),
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
