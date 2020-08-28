import 'package:cat_app/models/cats.dart';
import 'package:cat_app/services/the_cat_api.dart';
import 'package:flutter/material.dart';
import 'package:cat_app/components/cat_card.dart';

class HomePage extends StatefulWidget {
  List<Cat> cats = [];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    load();
    super.initState();
  }
  
  List<Cat> cats = [];
  
  void load() async {
    final dados = await getData();

    dados.forEach((element) {
      final currentCat = new Cat.fromJson(element);
      getImage(element['id']).then((image) {
        currentCat.setImage(image);
      });
      cats.add(currentCat);
    });

    setState(() {
      widget.cats = cats;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cat App'),
          backgroundColor: Colors.black87,
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: widget.cats.length,
                itemBuilder: (context, index) {
                  final currentCat = widget.cats[index];
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CatCard(
                          breed: currentCat.breed,
                          imageUrl: currentCat.imageUrl,
                          description: currentCat.description));
                });
          },
        ),
      ),
    );
  }
}
