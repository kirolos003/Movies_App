import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/UI/screens/movie_details/movie_details_screen.dart';
import 'package:movies_app/provider/app_prov.dart';
import 'package:movies_app/shared/components.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).getShows();
    Provider.of<AppProvider>(context, listen: false).getNewReleases();
    Provider.of<AppProvider>(context, listen: false).getRecommended();
    Provider.of<AppProvider>(context, listen: false).getFavorites();

  }
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                child: CarouselSlider(
                  items: provider.shows
                      .map((e) => InkWell(
                    onTap: () {
                      navigateTo(context, MovieDetailsScreen(movieId:e['id']));
                    },
                        child: Image(
                    image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/${e['poster_path']}'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                      ))
                      .toList(),
                  options: CarouselOptions(
                    height: 200,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 180,
            color: const Color(0xff292b29),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "New Releases",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: provider.newReleases.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Consumer<AppProvider>(
                          builder: (context, appProvider, child) {
                            return BuildNewReleasesItem(appProvider, appProvider.newReleases[index]['poster_path'] , appProvider.newReleases[index]['original_title'] , appProvider.newReleases[index]['id'] , index);
                          },
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 180,
            color: const Color(0xff292b29),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Recommended",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: provider.recommended.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Consumer<AppProvider>(
                          builder: (context, appProvider, child) {
                            return BuildNewReleasesItem(appProvider, appProvider.recommended[index]['poster_path'] , appProvider.recommended[index]['original_title'] , appProvider.recommended[index]['id'] , index);
                          },
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget BuildNewReleasesItem(AppProvider provider, String path , String title , int id , int index ) => InkWell(
    onTap: () {
      navigateTo(context, MovieDetailsScreen(movieId:id));
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Image(
                  width: 100,
                  image: NetworkImage('https://image.tmdb.org/t/p/w500/$path'),
                  // fit: BoxFit.cover,
                ),
                Positioned(
                  top: 1,
                  left: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: provider.favorites.contains(id) ? Colors.orangeAccent.withOpacity(0.6) : Colors.black.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: IconButton(
                        onPressed: () {
                          provider.changeFavorites(id , index , path , title);
                        },
                        icon: provider.favorites.contains(id) ? const Icon(Icons.check , color: Colors.white) : const Icon(Icons.add , color: Colors.white)
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text('$title', style: TextStyle(
            color: Colors.white
          ),)
        ],
      ),
    ),
  );

  Widget BuildRecommendedItem(AppProvider provider, String path, int id, int index , String title ) => InkWell(
    onTap: () {
      navigateTo(context, MovieDetailsScreen(movieId:id));
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image(
                    image: NetworkImage('https://image.tmdb.org/t/p/w500/$path'),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 3,
                      height: 3,
                      decoration: BoxDecoration(
                        color: provider.favorites.contains(id) ? Colors.orangeAccent.withOpacity(0.6) : Colors.black.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          provider.changeFavorites(id, index , path , title);
                        },
                        icon: provider.favorites.contains(id) ? const Icon(Icons.check, color: Colors.white) : const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ignore: prefer_const_constructors
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.star, color: Colors.orange),
                SizedBox(width: 5),
                Text("3.1" ,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white
                  ),),
              ],
            ),
            Text('$title',
              textAlign: TextAlign.start,
              style: const TextStyle(
                  color: Colors.white
              ),),
          ],
        ),
      ),
    ),
  );
}
