import 'package:flutter/material.dart';
import 'package:pokemon_flutter/controllers/pokemon_basic_controller.dart';
import 'package:provider/provider.dart';
import '../../controllers/theme_controller.dart';
import '../widgets/bottom_loading_bar_widget.dart';
import '../widgets/home_screen_sliver_app_bar.dart';
import '../widgets/custom_sliver_grid_view.dart';
import 'package:pokemon_flutter/utils/constants.dart' as constants;

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  int offset = 0;
  bool atBottom = false;
  bool loadData = false;

  @override
  void initState() {
    fetchPokemons();
    // pokemonLazyLoading();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constants.scaffoldDarkThemeColor,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: constants.mediumPadding),
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: const [
                CustomSliverAppBar(),
                SliverToBoxAdapter(child: SizedBox(height: constants.mediumPadding)),
                CustomSliverGridView(),
              ],
            )));
  }

  Future<void> fetchPokemons() async {
    await Provider.of<PokemonBasicDataController>(context, listen: false).getAllPokemons(offset);
  }
}
