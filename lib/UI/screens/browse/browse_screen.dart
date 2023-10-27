import 'package:flutter/material.dart';
import 'package:movies_app/shared/components.dart';
import 'package:provider/provider.dart';
import '../../../provider/app_prov.dart';
import 'category_details_screen.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    provider.getCategories();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Browse Category' , style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600
                ),),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 30
                  ),
                  itemCount: provider.categories.length,
                  itemBuilder: (context , index) => buildCategoryItem(provider.categories[index]['name'] , provider.categories[index]['id'], context)
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildCategoryItem(String category , int id ,  BuildContext context) => InkWell(
    onTap: (){
      navigateTo(context, CategoryDetailsScreen(id));
    },
    child: Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.srcOver),
              child: const Image(
                image: AssetImage("assets/images/back.png"),
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Text(
                category , style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20
              ),),
            )
          ],
        ),
      ),
    ),
  );
}
