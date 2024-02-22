import 'package:flutter/material.dart';
import 'package:movies_app/provider/app_prov.dart';
import 'package:provider/provider.dart';

import '../../../shared/components.dart';
import '../movie_details/movie_details_screen.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Watch List",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 30,
            ),
          ),
          Expanded(
            child: Consumer<AppProvider>(
              builder: (context, provider, _) {
                return ListView.separated(
                  separatorBuilder: (context, index) =>
                  const Divider(color: Color(0xff707070)),
                  itemBuilder: (context, index) => favoritesItemBuilder(
                    provider,
                    provider.favoritesFromFirebase[index]['poster_path'],
                    provider.favoritesFromFirebase[index]['title'],
                    provider.favoritesFromFirebase[index]['id'],
                    index,
                  ),
                  itemCount: provider.favoritesFromFirebase.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget favoritesItemBuilder(
      AppProvider provider,
      String path,
      String title,
      int id,
      int index,
      ) =>
      InkWell(
        onTap: (){
          navigateTo(context, MovieDetailsScreen(movieId:id));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Stack(
                children: [
                  Image(
                    image: NetworkImage('https://image.tmdb.org/t/p/w500/$path'),
                    width: 100,
                    height: 150,
                  ),
                  Positioned(
                    top: 1,
                    left: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: provider.favorites.contains(id)
                            ? Colors.orangeAccent.withOpacity(0.6)
                            : Colors.black.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          provider.changeFavorites(id, index, path, title);
                          Provider.of<AppProvider>(context, listen: false).getFavorites();
                          setState(() {

                          });
                        },
                        icon: provider.favorites.contains(id)
                            ? const Icon(Icons.check, color: Colors.white)
                            : const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}


