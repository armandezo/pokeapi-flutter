// import 'package:flutter/material.dart';
// import 'package:pokemon_flutter/services/pokemon_basic_service.dart';

// import '../models/pokemon_basic_data.dart';

// class PokemonBasicDataController with ChangeNotifier {
//   final List<PokemonBasicData> _pokemons = [];

//   List<PokemonBasicData> get pokemons {
//     return [..._pokemons];
//   }

//   final basicDataService = PokemonBasicDataService();

// ignore_for_file: constant_identifier_names

//   Future<void> getAllPokemons(int offset) async {
//     final fetchedPokemons = await basicDataService.getAllPokemons(offset);
//     for (var pokemon in fetchedPokemons) {
//       _pokemons.add(pokemon);
//     }
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:pokemon_flutter/services/pokemon_basic_service.dart';

import '../models/pokemon_basic_data.dart';

enum SortingOption {
  ID,
  Name,
}

class PokemonBasicDataController with ChangeNotifier {
  final List<PokemonBasicData> _pokemons = [];
  SortingOption _sortingOption = SortingOption.ID;

  List<PokemonBasicData> get pokemons {
    return [..._pokemons];
  }

  SortingOption get sortingOption {
    return _sortingOption;
  }

  final basicDataService = PokemonBasicDataService();

  Future<void> getAllPokemons(int offset) async {
    final fetchedPokemons = await basicDataService.getAllPokemons(offset);
    for (var pokemon in fetchedPokemons) {
      _pokemons.add(pokemon);
    }
    _sortPokemons();
    notifyListeners();
  }

  void setSortingOption(SortingOption option) {
    _sortingOption = option;
    _sortPokemons();
    notifyListeners();
  }

  void _sortPokemons() {
    switch (_sortingOption) {
      case SortingOption.ID:
        _pokemons.sort((a, b) => a.id.compareTo(b.id));
        break;
      case SortingOption.Name:
        _pokemons.sort((a, b) => a.name.compareTo(b.name));
        break;
    }
  }
}
