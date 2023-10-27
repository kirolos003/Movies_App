import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/app_prov.dart';

class CategoryDetailsScreen extends StatefulWidget {
  int id;
  static String category = '';

  CategoryDetailsScreen(this.id, {Key? key}) : super(key: key) {
    switch (id) {
      case 28:
        category = "Action";
        break;
      case 12:
        category = "Adventure";
        break;
      case 16:
        category = "Animation";
        break;
      case 35:
        category = "Comedy";
        break;
      case 80:
        category = "Crime";
        break;
      case 99:
        category = "Documentary";
        break;
      case 18:
        category = "Drama";
        break;
      case 10751:
        category = "Family";
        break;
      case 14:
        category = "Fantasy";
        break;
      case 36:
        category = "History";
        break;
      case 27:
        category = "Horror";
        break;
      case 10402:
        category = "Music";
        break;
      case 9648:
        category = "Mystery";
        break;
      case 10749:
        category = "Romance";
        break;
      case 878:
        category = "Science Fiction";
        break;
      case 10770:
        category = "TV Movie";
        break;
      case 53:
        category = "Thriller";
        break;
      case 10752:
        category = "War";
        break;
      case 37:
        category = "Western";
        break;
      default:
        category = "Unknown Category";
        break;
    }
  }

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {

  @override
  void initState() {
    super.initState();
    AppProvider provider = Provider.of<AppProvider>(context,listen: false);
    provider.getMoviesByCategories(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          CategoryDetailsScreen.category
          ,textAlign: TextAlign.start,
          style: const TextStyle(
          fontSize: 20 ,
          fontWeight: FontWeight.w400,
          color: Colors.white
        ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              '${CategoryDetailsScreen.category} : ',
              style: const TextStyle(
                  fontSize: 30 ,
                  fontWeight: FontWeight.w800,
                  color: Colors.white
              ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(color: Color(0xff707070)),
                itemBuilder: (context, index) => SearchItemBuilder(
                    provider.browse[index]['poster_path'],
                    provider.browse[index]['title'],
                    provider.browse[index]['release_date']
                ),
                itemCount: provider.browse.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget SearchItemBuilder(String image, String title, String date) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Image.network(
          'https://image.tmdb.org/t/p/w500/$image',
          width: 140,
          height: 89,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$title",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "$date",
                style: const TextStyle(
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
  );
}
