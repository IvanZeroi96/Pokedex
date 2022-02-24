import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/model/colors.dart';
import 'package:pokedex/view/detail/detail_page.dart';
import 'package:pokedex/view/home/home_page.dart';
import 'package:pokedex/view/splash/splash_page.dart';
import 'package:get/route_manager.dart' as route;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: PokeDexColors.blue,
        ),
        primaryTextTheme: const TextTheme(
          headline6: TextStyle(
              fontSize: 18.0,
              fontFamily: 'SFProMedium',
              fontWeight: FontWeight.w600),
          subtitle2: TextStyle(
            fontSize: 16.0,
            fontFamily: 'SFProMedium',
            color: Color(0xFF2E2E2E),
          ),
          bodyText2: TextStyle(
            fontSize: 16.0,
            fontFamily: 'SFProLight',
            color: Color(0xFF585858),
          ),
          bodyText1: TextStyle(
            fontSize: 15.0,
            fontFamily: 'SFProLight',
            color: Color(0xFF585858),
          ),
          headline5: TextStyle(
            fontSize: 20.0,
            fontFamily: 'SFProHeavy',
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
          subtitle1: TextStyle(
            fontSize: 18.0,
            fontFamily: 'SFProHeavy',
            color: Color(0xFF434343),
          ),
        ),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashPage(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomePage(),
          transition: route.Transition.fadeIn,
          transitionDuration: const Duration(
            milliseconds: 1000,
          ),
        ),
        GetPage(
          name: '/detail',
          page: () => const DetailPage(),
          fullscreenDialog: true,
          transition: route.Transition.fade,
          transitionDuration: const Duration(
            milliseconds: 1000,
          ),
        ),
      ],
    );
  }
}
