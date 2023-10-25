import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/shows/shows.dart';
import 'package:movies_app/provider/app_prov.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var onBoardingController = PageController();
  bool? isLast = false;

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    provider.getShows();
    provider.getNewReleases();
    provider.getRecommended();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: provider.bottomScreens[provider.currentIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.black),
          child: BottomNavigationBar(
            iconSize: 30,
            selectedItemColor: Colors.orange,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            currentIndex: provider.currentIndex,
            onTap: (index){
              provider.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home ), label: "HOME" , backgroundColor: Colors.black),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "SEARCH"),
              BottomNavigationBarItem(icon: Icon(Icons.movie), label: "BROWSE"),
              BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "WATCHLIST"),
            ],
          ),
        ),
      ),
    );
  }
}
