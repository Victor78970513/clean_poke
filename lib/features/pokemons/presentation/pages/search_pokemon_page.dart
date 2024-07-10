import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/presentation/bloc/pokemons_bloc.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/presentation/widgets/pokemon_card.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/presentation/widgets/search_pokemon_widget.dart';
import 'package:pokemon_clean_arquitecture/service_locator.dart';

class SearchPokemonPage extends StatefulWidget {
  const SearchPokemonPage({super.key});

  @override
  State<SearchPokemonPage> createState() => _SearchPokemonPageState();
}

class _SearchPokemonPageState extends State<SearchPokemonPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => serviceLocator<PokemonsBloc>(),
      child: BlocConsumer<PokemonsBloc, PokemonsState>(
          listener: (context, state) {},
          builder: (context, state) {
            switch (state) {
              case SearchPokemonLoading():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case SearchPokemonError():
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SearchPokemonWidget(controller: controller),
                      const SizedBox(height: 20),
                      const Text("No se encontro al pokemon"),
                    ],
                  ),
                );
              case SearchPokemonSuccess():
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SearchPokemonWidget(controller: controller),
                    const SizedBox(height: 20),
                    PokemonCard(pokemonEntity: state.pokemon),
                  ],
                ));
              default:
                return Center(
                  child: SearchPokemonWidget(controller: controller),
                );
            }
          }),
    ));
  }
}
