import 'package:flutter/material.dart';
import 'package:movies_app/provider/app_prov.dart';
import 'package:provider/provider.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Watch List" , style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 30
          ),),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(color: Color(0xff707070)),
              itemBuilder: (context, index) => favoritesItemBuilder(
                  provider.favorites[index],),
              itemCount: provider.favorites.length,
            ),
          )
        ],
      ),
    );
  }

  Widget favoritesItemBuilder(String id) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w500/',
              width: 140,
              height: 89,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20,
            ),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
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
      );
}
