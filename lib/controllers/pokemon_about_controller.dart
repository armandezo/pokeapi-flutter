import 'package:flutter/material.dart';
import 'package:pokemon_flutter/models/pokemon_basic_data.dart';
import 'package:pokemon_flutter/services/pokemon_about_data_service.dart';

import '../models/pokemon_about_data.dart';

class PokemonAboutDataController with ChangeNotifier {
  final pokemonAboutDataService = PokemonAboutDataService();

  Future<void> getPokemonAboutData(PokemonBasicData pokemon) async {
    final response = await pokemonAboutDataService.getPokemonAboutData(pokemon);
    PokemonAboutData pokemonAboutData = PokemonAboutData(
      baseHappiness: response['baseHappiness'],
      captureRate: response['captureRate'],
      flavorText: response['flavorText'],
      growthRate: response['growthRate'],
      habitat: response['habitat'],
      eggGroups: response['eggGroups'],
    );
    pokemon.pokemonAboutData = pokemonAboutData;
  }
}
