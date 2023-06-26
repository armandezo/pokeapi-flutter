import 'package:flutter/material.dart';
import 'package:pokemon_flutter/controllers/pokemon_basic_controller.dart';
import 'package:pokemon_flutter/controllers/theme_controller.dart';
import 'package:pokemon_flutter/ui/screens/favorite_screen.dart';
import 'package:pokemon_flutter/ui/screens/search_screen.dart';
import 'package:pokemon_flutter/utils/constants.dart' as constants;
import 'package:provider/provider.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Provider.of<ThemeController>(context).themeData;
    bool isDark = themeData == ThemeData.dark();

    return SliverAppBar(
      expandedHeight: constants.homeScreenSliverAppBarHeight,
      backgroundColor: constants.scaffoldLightThemeColor,
      elevation: 0,
      pinned: false,
      floating: true,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).viewPadding.top + constants.screenTopPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/pokeball.png',
                        height: 30,
                        width: 30,
                        color: constants.searchIconDarkThemeColor,
                      ),
                      const SizedBox(width: constants.mediumPadding),
                      Text(
                        constants.homeScreenTitle,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: isDark ? constants.homeScreenTitleDarkThemeColor : constants.homeScreenTitleLightThemeColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: constants.favoriteIconContainerDarkThemeColor,
                      borderRadius: BorderRadius.circular(constants.containerCornerRadius),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.favorite_rounded),
                      color: constants.homeScreenTitleLightThemeColor,
                      onPressed: () {
                        navigateToScreen(context, FavoriteScreen.routeName);
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: constants.mediumPadding),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: constants.smallPadding),
                        height: 40,
                        decoration: BoxDecoration(
                          color: constants.searchContainerLightThemeColor,
                          borderRadius: BorderRadius.circular(constants.containerCornerRadius),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.search,
                              color: constants.leftSearchIconColor,
                            ),
                            SizedBox(width: constants.mediumPadding),
                            Text(
                              constants.searchHintText,
                              style: TextStyle(color: constants.searchHintTextColor),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        navigateToScreen(context, SearchScreen.routeName);
                      },
                    ),
                  ),
                  const SizedBox(width: constants.mediumPadding),
                  GestureDetector(
                    onTap: () {
                      // _showSortingOptionsDialog(context);
                    },
                    child: const CircleAvatar(
                      backgroundColor: constants.searchIconDarkThemeColor,
                      child: Icon(Icons.menu_outlined, color: constants.searchIconLightThemeColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToScreen(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void _showSortingOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedOption;
        return AlertDialog(
          title: const Text('Ordenar por'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: const Text('ID'),
                    value: 'id',
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Nombre'),
                    value: 'nombre',
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                // if (selectedOption == 'id') {
                //   Provider.of<PokemonBasicDataController>(context, listen: false).setSortingOption(SortingOption.ID);
                // } else if (selectedOption == 'nombre') {
                //   Provider.of<PokemonBasicDataController>(context, listen: false).setSortingOption(SortingOption.Name);
                // }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
