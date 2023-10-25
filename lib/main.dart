import 'package:flutter/material.dart';
import 'package:movies_app/Network/remote/dio_helper.dart';
import 'package:movies_app/UI/screens/splash_screen.dart';
import 'package:movies_app/provider/app_prov.dart';
import 'package:provider/provider.dart';

import 'Network/local/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => AppProvider()..getShows..getNewReleases()..getRecommended()..getCategories(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

