import 'dart:convert';

import 'package:flutter_pokedex/consts/consts_api.dart';
import 'package:flutter_pokedex/models/pokeapi.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
part 'pokeapi_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {

  @observable
  PokeAPI _pokeAPI;

  @computed 
  PokeAPI get pokeAPI => _pokeAPI;

  @action
  fetchPokemonList() {
    loadPokeAPI().then((pokeList) {
      _pokeAPI = pokeList;
    });
  }

  Future<PokeAPI> loadPokeAPI() async {
    try {
      final response = await http.get(ConstsAPI.pokeapiURL);
      var decodeJson = jsonDecode(response.body);
      return PokeAPI.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }
}
