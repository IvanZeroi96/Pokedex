
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/controller/pokedex_get_controller.dart';
import 'package:pokedex/model/home/pokemons_model.dart';
import 'package:pokedex/model/network/network.dart';

class HomeController extends PokedexGetXController{
  Pokemon? _pokemon;
  final CarouselController _carrouselController = CarouselController();
  final List<Result> _pokemons = [];
  bool _loading = false;

  Pokemon? get pokemon => _pokemon;
  CarouselController get carrouselController => _carrouselController;
  List<Result> get pokemons => _pokemons;
  bool get loading => _loading;

  @override
  void onInit() {
    super.onInit();
    _getPokemons();
  }

  void _getPokemons() async {
    _loading = true;
    update(['ListPokemons']);

    final network = Network();
    _pokemon = await network.getListaPokemons();
    if(_pokemon != null){

    }
    _loading = false;
    update(['ListPokemons']);
  }

  void onChangePokemon(int index, CarouselPageChangedReason carouselPageChangedReason){
    debugPrint('-> $index');
  }

  void getBusqueda(String? v,BuildContext context){
    int position = 0;
    int _numero = 0;
    bool _busqueda = false;
    bool _sonNumeros = false;

    try{
      _numero = int.parse(v!);
      _sonNumeros = true;
    }catch(e){
      _sonNumeros = false;
    }

    if(_sonNumeros){
      if(_numero < 152) {
        _carrouselController.animateToPage(
            _numero - 1, duration: const Duration(seconds: 8),
            curve: Curves.bounceOut);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          showSnackBar('Solo puedes buscar 151 pokemons'),
        );
      }
    }else{
      for (var element in _pokemon!.results!) {
        if(element.name == v){
          _busqueda = true;
          break;
        }
        position++;
      }
      if(_busqueda) {
        _carrouselController.animateToPage(position,duration: const Duration(seconds: 8),curve: Curves.bounceOut);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          showSnackBar('Ningun resultado de busqueda.'),
        );
      }
    }
  }

  SnackBar showSnackBar(String titulo) {
    final snackBar = SnackBar(
      key: const Key('ModeStand'),
      content: Text(titulo),
      duration: const Duration(seconds: 4),
      padding: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );

    return snackBar;
  }

  void openDetail(int index){
    Get.toNamed('/detail',arguments: {'IdPokemon' : index.toString()});
  }
}