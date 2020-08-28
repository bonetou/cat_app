import 'package:flutter/material.dart';

class CatCard extends StatelessWidget {
  final String breed;
  final String imageUrl;
  final String description;

  const CatCard({this.breed, this.imageUrl, this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      shadowColor: Colors.black,
      color: Colors.amber[100],
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              breed,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(30),
              child: Image.network(imageUrl != null
                  ? imageUrl
                  : 'https://imagens2.ne10.uol.com.br/blogsjconline/oviral/2019/12/peixe-penis.jpg'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                description,
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
