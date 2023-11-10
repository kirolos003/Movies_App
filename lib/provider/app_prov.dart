import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Network/remote/dio_helper.dart';
import 'package:movies_app/UI/screens/browse/browse_screen.dart';
import 'package:movies_app/UI/screens/main_screen.dart';
import 'package:movies_app/UI/screens/search/search_screen.dart';
import 'package:movies_app/UI/screens/watch_list/watch_list_screen.dart';

class AppProvider extends ChangeNotifier {

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const MainScreen(),
    SearchScreen(),
    const BrowseScreen(),
    const WatchListScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<dynamic> shows = [];

  Future<void> getShows() async {
     await DioHelper.getData(
        url: 'movie/popular',
        query: {
          'api_key': '026d58483e3ff0e05eb2e94b38125ce5',
        }

    )?.then((value) {
      shows = value?.data['results'];
    }).catchError((error) {
      print(error.toString());
    });
    notifyListeners();
  }

  List<dynamic> newReleases = [];

  Future<void> getNewReleases() async {
  await DioHelper.getData(
        url: 'movie/upcoming',
        query: {
          'api_key': '026d58483e3ff0e05eb2e94b38125ce5',
        }
    )?.then((value) {
      newReleases = value?.data['results'];
    }).catchError((error) {
      print(error.toString());
    });
  notifyListeners();
  }

  List<dynamic> recommended = [];

  Future<void> getRecommended() async {
  await  DioHelper.getData(
        url: 'movie/top_rated',
        query: {
          'api_key': '026d58483e3ff0e05eb2e94b38125ce5',
        }
    )?.then((value) {
      recommended = value?.data['results'];
    }).catchError((error) {
      print(error.toString());
    });
  notifyListeners();
  }

  List<dynamic> favorites = [];

  List<dynamic> favoritesFromFirebase = [];

  void changeFavorites(int id, int index , String poster_path , String title) {
    if (favorites.contains(id)) {
      favorites.remove(id);
      FirebaseFirestore.instance.collection('favorites').doc(id.toString()).delete();
    } else {
      favorites.add(id);
      FirebaseFirestore.instance.collection('favorites').doc(id.toString()).set({
        'id': id,
        'poster_path': poster_path,
        'title': title,
      });
    }
    notifyListeners();
    print(favorites);
  }

  void getFavorites() {
    print("got here 1");
    FirebaseFirestore.instance.collection('favorites').get().then((value) {
      favoritesFromFirebase = value.docs.map((e) => {
        'id': e.data()['id'],
        'poster_path': e.data()['poster_path'],
        'title': e.data()['title'],
      }).toList();
      favorites = value.docs.map((e) => e.data()['id']).toList();
      notifyListeners();
    });
  }

  List<dynamic> search = [];

  Future<void> getSearch(String text) async {
    print("query: $text");
   await DioHelper.getData(
        url: 'search/movie',
        query: {
          'api_key': '026d58483e3ff0e05eb2e94b38125ce5',
          'query' : text
        }
    )?.then((value) {
      search = value?.data['results'];
    }).catchError((error) {
      print(error.toString());
    });
   notifyListeners();
  }

  List<dynamic> categories = [];

  void getCategories() {
    DioHelper.getData(
        url: 'genre/movie/list',
        query: {
          'api_key': '026d58483e3ff0e05eb2e94b38125ce5',
        }
    )?.then((value) {
      categories = value?.data['genres'];
    }).catchError((error) {
      print(error.toString());
    });
  }

  List<dynamic> browse = [];

  Future<void> getMoviesByCategories(int id) async {
    print("id: $id");
   await DioHelper.getData(
        url: 'discover/movie',
        query: {
          'api_key': '026d58483e3ff0e05eb2e94b38125ce5',
          'with_genres' : id
        }
    )?.then((value) {
      browse = value?.data['results'];
      print(browse);
    }).catchError((error) {
      print(error.toString());
    });
   notifyListeners();
  }
}