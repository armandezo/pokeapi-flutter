import 'package:flutter/material.dart';
import 'package:pokemon_flutter/models/pokemon_basic_data.dart';
import 'package:pokemon_flutter/services/pokemon_more_info_service.dart';

import '../models/pokemon_more_info_data.dart';

class PokemonMoreInfoController with ChangeNotifier {
  final pokemonAboutDataService = PokemonMoreInfoService();

  Future<void> getPokemonMoreInfoData(PokemonBasicData pokemon) async {
    final response = await pokemonAboutDataService.fetchPokemonMoreIndoData(pokemon);

    PokemonMoreInfoData pokemonDetailedInfo = PokemonMoreInfoData(
      height: response['height'],
      weight: response['weight'],
      abilities: response['abilities'],
      types: response['types'],
      moves: response['moves'],
    );
    pokemon.pokemonMoreInfoData = pokemonDetailedInfo;
  }
}
