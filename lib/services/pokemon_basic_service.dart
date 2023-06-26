import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_basic_data.dart';

class PokemonBasicDataService {
  Future<List<PokemonBasicData>> getAllPokemons(int offset) async {
    List<PokemonBasicData> pokemons = [];
    try {
      if (offset >= 10) {
        return pokemons;
      }

      Uri basicUrl = Uri.https('pokeapi.co', '/api/v2/pokemon', {'limit': '10', 'offset': offset.toString()});
      final response = await http.get(basicUrl);
      List<dynamic> fetchedData = [];

      if (response.statusCode == 200) {
        fetchedData = json.decode(response.body)['results'];

        for (var pokemon in fetchedData) {
          final pokemonName = pokemon['name'].substring(0, 1).toUpperCase() + pokemon['name'].substring(1);

          pokemons.add(PokemonBasicData(name: pokemonName, url: pokemon['url']));
        }
      }
      return pokemons;
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getPokemonByName(String name) async {
    Map<String, dynamic> pokemon = {};
    final nameLowerCase = name.toLowerCase();
    try {
      Uri basicUrl = Uri.https('pokeapi.co', '/api/v2/pokemon/$nameLowerCase');
      final response = await http.get(basicUrl);
      if (response.statusCode == 200) {
        final pokemonData = json.decode(response.body);

        String pokemonIdPadLeft = '';
        int id = pokemonData['id'];
        pokemonIdPadLeft = (id).toString().padLeft(3, '0');
        String imageUrl = 'https://assets.pokemon.com/assets/cms2/img/pokedex/full/$pokemonIdPadLeft.png';
        final pokemonUrl = 'https://pokeapi.co/api/v2/$nameLowerCase';

        pokemon = {
          'name': name,
          'id': pokemonIdPadLeft,
          'url': pokemonUrl,
          'imageUrl': imageUrl,
        };
      }
      return pokemon;
    } catch (error) {
      rethrow;
    }
  }
}
