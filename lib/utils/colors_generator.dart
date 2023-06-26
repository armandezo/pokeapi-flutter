import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorsGenerator {
  Future<Color> generateCardColor(String pokemonImageUrl, bool isDarkTheme) async {
    Color cardColor = Colors.black.withOpacity(0.5);
    try {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(pokemonImageUrl));
      if (paletteGenerator.dominantColor != null) {
        if (isDarkTheme) {
          cardColor = paletteGenerator.dominantColor!.color.withAlpha(500);
        } else {
          cardColor = paletteGenerator.dominantColor!.color.withOpacity(0.25);
        }
      }
    } catch (error) {
      rethrow;
    }
    return cardColor;
  }
}
