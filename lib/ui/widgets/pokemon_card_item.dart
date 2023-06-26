import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_flutter/utils/colors_generator.dart';
import 'package:pokemon_flutter/utils/constants.dart' as constants;
import 'package:pokemon_flutter/models/pokemon_basic_data.dart';
import '../screens/pokemon_detail_screen.dart';

class PokemonCardItem extends StatefulWidget {
  final PokemonBasicData pokemon;
  final bool isDark;
  final String imageUrl;
  final String id;

  const PokemonCardItem({Key? key, required this.isDark, required this.pokemon, required this.imageUrl, required this.id}) : super(key: key);

  @override
  State<PokemonCardItem> createState() => _PokemonCardItemState();
}

class _PokemonCardItemState extends State<PokemonCardItem> {
  Color cardColor = Colors.transparent;
  late Map<String, String> getPokemonIdAndImage;
  bool colorReady = false;

  @override
  void initState() {
    generateContainerColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonBasicInfo = widget.pokemon;

    // update ids and imageUrls
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(PokemonDetailScreen.routeName, arguments: {'pokemon': pokemonBasicInfo, 'color': cardColor, 'imageUrl': widget.imageUrl});
      },
      child: Builder(builder: (context) {
        if (colorReady) {
          return Container(
            padding: const EdgeInsets.all(constants.mediumPadding),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(constants.containerCornerRadius)),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('#${widget.id}',
                      style: TextStyle(color: constants.pokemonIdLightThemeColor, fontSize: Theme.of(context).textTheme.titleMedium?.fontSize)),
                ),
                Hero(
                  tag: pokemonBasicInfo.name,
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    fit: BoxFit.cover,
                    height: 70,
                    width: 70,
                    fadeInDuration: const Duration(milliseconds: 150),
                    fadeOutDuration: const Duration(milliseconds: 150),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                Text(
                  pokemonBasicInfo.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: constants.pokemonNameLightThemeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: Theme.of(context).textTheme.titleSmall?.fontSize),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator(color: constants.circularProgressIndicatorColor));
        }
      }),
    );
  }

  Future<void> generateContainerColor() async {
    ColorsGenerator colorsGenerator = ColorsGenerator();
    Color generatedColor = await colorsGenerator.generateCardColor(widget.imageUrl, widget.isDark);
    if (mounted) {
      setState(() {
        colorReady = true;
        cardColor = generatedColor;
      });
    }
  }
}
