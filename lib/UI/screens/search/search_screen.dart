import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/app_prov.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String search = "";

    @override
    Widget build(BuildContext context) {
      AppProvider provider = Provider.of<AppProvider>(context);
      Widget searchResultWidget;
      if (provider.search.isEmpty) {
        searchResultWidget = Center(
          child: Image.asset('assets/images/empty.png'),
        );
      } else {
        searchResultWidget = ListView.separated(
          separatorBuilder: (context, index) => const Divider(color: Color(0xff707070)),
          itemBuilder: (context, index) => SearchItemBuilder(
              provider.search[index]['poster_path'],
              provider.search[index]['title'],
              provider.search[index]['release_date']
          ),
          itemCount: provider.search.length,
        );
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0 , vertical: 10),
            child: TextField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xff514F4F),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide.none,
                ),
                hintText: "Type anything to search",
                hintStyle: TextStyle(color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
                if(search == ""){
                  setState((){
                    searchResultWidget = Center(
                      child: Image.asset('assets/images/empty.png'),
                    );
                  });
                }
                provider.getSearch(search);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: searchResultWidget,
            ),
          ),
        ],
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


