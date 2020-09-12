import 'package:cat_app/models/cats.dart';
import 'package:cat_app/services/the_cat_api.dart';
import 'package:flutter/material.dart';
import 'package:cat_app/components/cat_card.dart';

import '../services/the_cat_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Cat>> futureCats;
  PageController _pageController = PageController();
  int maxPages = 14;
  int currentPage = 1;
  @override
  void initState() {
    super.initState();
    futureCats = getData(currentPage);
    _pageController.addListener(() {
      if (_pageController.position.pixels == _pageController.position.maxScrollExtent && currentPage <= maxPages) {
        setState(() {
          print(currentPage);
          currentPage++;
          futureCats = getData(currentPage);          
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cat Breeds',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: InkWell(
            borderRadius: BorderRadius.circular(30),
            splashColor: Colors.black12,
            onTap: () {},
            child: Icon(
              Icons.menu,
              color: Colors.black87,
            ),
          ),
          actions: <Widget>[
            InkWell(
              borderRadius: BorderRadius.circular(30),
              splashColor: Colors.black12,
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Icon(
                  Icons.search,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        body: FutureBuilder<List<Cat>>(
          future: futureCats,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var cats = snapshot.data;
              return Column(children: [
                //TopCustomBar(),
                SizedBox(height: 100),
                Container(
                  width: 400,
                  height: 400,
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: cats.length,
                      itemBuilder: (context, index) {
                        final currentCat = cats[index];
                        return CatCard(
                          breed: currentCat.breed,
                          imageUrl: currentCat.imageUrl,
                          description: currentCat.description,
                        );
                      }),
                ),
              ]);
            } else {
              return SafeArea(
                  child: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ));
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Favorite'),
            )
          ],
        ),
      ),
    );
  }
}
