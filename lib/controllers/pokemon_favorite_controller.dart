import 'package:flutter/cupertino.dart';
import 'package:pokemon_flutter/services/pokemon_basic_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pokemon_basic_data.dart';

class PokemonFavoritesController with ChangeNotifier {
  PokemonBasicDataService pokemonBasicDataService = PokemonBasicDataService();

  late SharedPreferences prefs;

  List<String> _favoritePokemonsNames = [];

  List<PokemonBasicData> _favoritePokemons = [];

  List<PokemonBasicData> get favoritePokemons {
    return [..._favoritePokemons];
  }

  void sortList(List<String> savedPokemons) {
    savedPokemons.sort((item1, item2) => item1.compareTo(item2));
  }

  Future<void> toggleFavoritePokemon(String pokemonName) async {
    prefs = await SharedPreferences.getInstance();
    List<String>? savedPokemons = [];
    savedPokemons = prefs.getStringList('favoritePokemons');

    savedPokemons ??= [];

    if (savedPokemons.contains(pokemonName)) {
      savedPokemons.removeWhere((name) => pokemonName == name);
      _favoritePokemons.removeWhere((pokemon) => pokemon.name == pokemonName);
    } else {
      savedPokemons.add(pokemonName);
    }
    prefs.setStringList('favoritePokemons', savedPokemons);
    _favoritePokemonsNames = savedPokemons;

    notifyListeners();
  }

  Future<void> loadFavoritePokemonsNamesFromSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? savedPokemons = [];
    savedPokemons = prefs.getStringList('favoritePokemons');
    savedPokemons ??= [];
    sortList(savedPokemons);
    _favoritePokemonsNames = savedPokemons;
    notifyListeners();
  }

  Future<bool> isPokemonFavorite(String pokemonName) async {
    prefs = await SharedPreferences.getInstance();
    List<String>? savedPokemons = [];
    savedPokemons = prefs.getStringList('favoritePokemons');

    savedPokemons ??= [];
    if (savedPokemons.contains(pokemonName)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getFavoritePokemonsData() async {
    List<PokemonBasicData> favPokemons = [];
    await loadFavoritePokemonsNamesFromSharedPref();

    for (String name in _favoritePokemonsNames) {
      final pokemonData = await pokemonBasicDataService.getPokemonByName(name);
      final PokemonBasicData basicPokemonData =
          PokemonBasicData(name: pokemonData['name'], url: pokemonData['url'], id: pokemonData['id'], imageUrl: pokemonData['imageUrl']);
      favPokemons.add(basicPokemonData);
    }
    _favoritePokemons = favPokemons;
    notifyListeners();
  }
}
