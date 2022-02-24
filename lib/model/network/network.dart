import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex/model/constants.dart';
import 'package:pokedex/model/detail/pokemon_detail_model.dart';
import 'package:pokedex/model/home/pokemons_model.dart';
import 'package:http/http.dart' as http;

class Network {
  Future<dynamic> getListaPokemons() async{
    Pokemon? objectResponse;
    try{
      var url = Uri.parse(WebService().baseUrlSearch + '?limit=151');
      debugPrint('Url -> ' + url.toString());
      await http.get(url).then((response){
        if (response.statusCode == 200 || response.statusCode == 201) {
          objectResponse = Pokemon.fromJson(jsonDecode(response.body.replaceAll('\'', '')));
        }else {
          objectResponse = null;
        }
      });
      return objectResponse;
    }catch(id){
      debugPrint(id.toString());
      return null;
    }
  }

  Future<dynamic> getDetailPokemons(String id) async{
    PokemonDetail? objectResponse;
    try{
      var url = Uri.parse(WebService().baseUrlSearch + '/$id');
      debugPrint('Url -> ' + url.toString());
      await http.get(url).then((response){
        if (response.statusCode == 200 || response.statusCode == 201) {
          objectResponse = PokemonDetail.fromJson(jsonDecode(response.body.replaceAll('\'', '')));
        }else {
          objectResponse = null;
        }
      });
      return objectResponse;
    }catch(id){
      debugPrint(id.toString());
      return null;
    }
  }
}