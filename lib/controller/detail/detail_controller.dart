
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/controller/pokedex_get_controller.dart';
import 'package:pokedex/model/detail/pokemon_detail_model.dart';
import 'package:pokedex/model/network/network.dart';

class DetailController extends PokedexGetXController{

  PokemonDetail? _pokemonDetail;
  String? _idPokemon = '0';
  String? _abilities = '';
  String? _species = '';
  String? _type = '';
  bool _error = false;
  bool _loading = true;

  PokemonDetail? get pokemonDetail => _pokemonDetail;
  String? get idPokemon => _idPokemon;
  String? get abilities => _abilities;
  String? get species => _species;
  String? get type => _type;
  bool get error => _error;
  bool get loading => _loading;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments != null){
      _idPokemon = Get.arguments['IdPokemon'];
      _getDetailsPokemon();
    }else{
      _error = true;
      update(['Details']);
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void _getDetailsPokemon() async {
    _loading = true;
    update(['Details']);

    final network = Network();
    _pokemonDetail = await network.getDetailPokemons(_idPokemon!);
    if(_pokemonDetail != null){
      for (var element in _pokemonDetail!.abilities!) {
        _abilities = '$_abilities ${element.ability!.name},';
      }
      for(var element in _pokemonDetail!.forms!){
        _species = '$_species ${element.name},';
      }
      for(var element in _pokemonDetail!.types!){
        _type = '$_type ${element.type!.name},';
      }
    }else{
      _error = true;
    }
    debugPrint('-> $_pokemonDetail');
    _loading = false;
    update(['Details']);
  }
}