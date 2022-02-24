import 'dart:async';

import 'package:get/get.dart';
import 'package:pokedex/controller/pokedex_get_controller.dart';

class SplashController extends PokedexGetXController {
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    Future.delayed(
      const Duration(
        seconds: 4,
      ),
      () {
        Get.offNamed('/home');
      },
    );
  }
}
