import 'package:flutter/material.dart';
import 'package:movies_app/provider/app_prov.dart';
import 'package:movies_app/shared/components.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  int movieId;
  MovieDetailsScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AppProvider>(context, listen: false)
          .getMovieDetails(widget.movieId);
      Provider.of<AppProvider>(context, listen: false).getMoreLikeThis(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 200,
                    child: Image(
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/${provider.movieDetail["poster_path"]}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  provider.movieDetail['title'] ?? 'Unknown Title',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  provider.movieDetail['release_date'] ?? 'Unknown Title',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * (40 / 100),
                  height: MediaQuery.of(context).size.height * (25 / 100),
                  child: Image(
                    image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${provider.movieDetail["backdrop_path"]}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: ListView.builder(
                            itemBuilder: (context, index) => BuildGeneresItem(
                              provider.movieDetail['genres'][index]['name'],
                            ),
                            itemCount: provider.genres.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          provider.movieDetail['overview'] ?? 'Unknown Title',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 30,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              provider.movieDetail['vote_average'].toString() ??
                                  'Unknown Title',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "(${provider.movieDetail['vote_count'] ?? 'Unknown Title'})",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 250,
                  color: const Color(0xff292b29),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "More Like This",
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
                                  return BuildMoreLikeThisItem(widget,context , appProvider , appProvider.moreLikeThis[index]['poster_path'] , appProvider.moreLikeThis[index]['id'] , index , appProvider.moreLikeThis[index]['original_title']);
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
          ),
        ),
      ),
    );
  }
}

Widget BuildGeneresItem(String type) => Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        type,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.start,
      ),
    );

Widget BuildMoreLikeThisItem(
    MovieDetailsScreen widget,
    BuildContext context,
    AppProvider provider,
    String? path,
    int id,
    int index,
    String title,
    ) {
  return InkWell(
    onTap: () async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (build) => MovieDetailsScreen(movieId: id),
        ),
      );
      provider.getMovieDetails(widget.movieId);
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
                  if (path != null)
                    Image(
                      image: NetworkImage('https://image.tmdb.org/t/p/w500/$path'),
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
                          provider.changeFavorites(id, index, path ?? '', title);
                        },
                        icon: provider.favorites.contains(id)
                            ? const Icon(Icons.check, color: Colors.white)
                            : const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.star, color: Colors.orange),
                SizedBox(width: 5),
                Text(
                  "3.1",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

