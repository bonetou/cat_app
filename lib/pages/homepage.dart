import 'package:cat_app/models/cats.dart';
import 'package:cat_app/services/the_cat_api.dart';
import 'package:flutter/material.dart';
import 'package:cat_app/components/cat_card.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';

import '../services/the_cat_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Cat>> futureCats;
  @override
  void initState() {
    super.initState();
    futureCats = getData();
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
        body: FutureBuilder<List<Cat>>(
          future: futureCats,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print(snapshot.data);
              var cats = snapshot.data;
              return ListView.builder(
                  itemCount: cats.length,
                  itemBuilder: (context, index) {
                    final currentCat = cats[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CatCard(
                        breed: currentCat.breed,
                        imageUrl: currentCat.imageUrl,
                        description: currentCat.description,
                      ),
                    );
                  });
            } else {
              return CardListSkeleton(
                style: SkeletonStyle(
                  theme: SkeletonTheme.Dark,
                  isShowAvatar: true,
                  isCircleAvatar: true,
                  barCount: 2,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
