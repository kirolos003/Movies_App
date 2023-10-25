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

  void getShows() {
    DioHelper.getData(
        url: 'movie/popular',
        query: {
          'api_key': '026d58483e3ff0e05eb2e94b38125ce5',
        }
    )?.then((value) {
      shows = value?.data['results'];
    }).catchError((error) {
      print(error.toString());
    });
  }

  List<dynamic> newReleases = [];

  void getNewReleases() {
    DioHelper.getData(
        url: 'movie/upcoming',
        query: {
          'api_key': '026d58483e3ff0e05eb2e94b38125ce5',
        }
    )?.then((value) {
      newReleases = value?.data['results'];
    }).catchError((error) {
      print(error.toString());
    });
  }

  List<dynamic> recommended = [];

  void getRecommended() {
    DioHelper.getData(
        url: 'movie/top_rated',
        query: {
          'api_key': '026d58483e3ff0e05eb2e94b38125ce5',
        }
    )?.then((value) {
      recommended = value?.data['results'];
    }).catchError((error) {
      print(error.toString());
    });
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

  void getSearch(String text) {
    DioHelper.getData(
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
      print(categories);
    }).catchError((error) {
      print(error.toString());
    });
  }
}