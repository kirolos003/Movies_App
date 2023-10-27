
import 'package:flutter/material.dart';
import 'package:movies_app/Network/local/cache_helper.dart';
import 'package:movies_app/Network/remote/dio_helper.dart';
import 'package:movies_app/UI/screens/browse/browse_screen.dart';
import 'package:movies_app/UI/screens/main_screen.dart';
import 'package:movies_app/UI/screens/search/search_screen.dart';
import 'package:movies_app/UI/screens/watch_list/watch_list_screen.dart';

class AppProvider extends ChangeNotifier {

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    MainScreen(),
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
      // print(shows);
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

  void changeFavorites(int id, int index) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    notifyListeners();
    print(favorites);
  }

  List<dynamic> search = [];

  Future<void> getSearch(String text) async {
    print("query: $text");
   await DioHelper.getData(
        url: 'search/movie',
        query: {
          'api_key': '026d58483e3ff0e05eb2e94b38125ce5',
          'query' : '$text'
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
//  https://api.themoviedb.org/3/discover/movie?api_key=026d58483e3ff0e05eb2e94b38125ce5&genre_ids=53
}