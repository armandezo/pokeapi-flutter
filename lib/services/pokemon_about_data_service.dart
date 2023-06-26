import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon_basic_data.dart';

class PokemonAboutDataService {
  Future<Map<String, dynamic>> getPokemonAboutData(PokemonBasicData pokemon) async {
    Map<String, dynamic> pokemonAboutData = {};
    String pokemonNameLowerCase = pokemon.name.toLowerCase();
    Uri url = Uri.http('pokeapi.co', 'api/v2/pokemon-species/$pokemonNameLowerCase');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var pokemonInfo = json.decode(response.body);
        int baseHappiness = pokemonInfo['base_happiness'];
        int captureRate = pokemonInfo['capture_rate'];
        var habitatData = pokemonInfo['habitat'];
        String habitat = 'Unknown';
        if (habitatData != null) {
          habitat = habitatData['name'];
        }
        String growthRate = pokemonInfo['growth_rate']['name'];
        String flavorText = pokemonInfo['flavor_text_entries'][0]['flavor_text'];
        String flavorTextEdited = flavorText.replaceAll(RegExp('\n'), '');

        List<String> eggGroupNames = [];
        List eggGroups = pokemonInfo['egg_groups'];
        for (var eggGroup in eggGroups) {
          eggGroupNames.add(eggGroup['name']);
        }

        pokemonAboutData = {
          'baseHappiness': baseHappiness,
          'captureRate': captureRate,
          'habitat': habitat,
          'growthRate': growthRate,
          'flavorText': flavorTextEdited,
          'eggGroups': eggGroupNames,
        };
      }
      return pokemonAboutData;
    } catch (error) {
      rethrow;
    }
  }
}
