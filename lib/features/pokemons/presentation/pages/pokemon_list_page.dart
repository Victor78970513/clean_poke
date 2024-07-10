import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/presentation/bloc/pokemons_bloc.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/presentation/pages/search_pokemon_page.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/presentation/widgets/pokemon_card.dart';
// import 'package:pokemon_clean_arquitecture/service_locator.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  final ScrollController scrollController = ScrollController();
  int offset = 0;
  @override
  void initState() {
    scrollController.addListener(_onScroll);
    context.read<PokemonsBloc>().add(OnGetPokemonsList(offset: offset));
    super.initState();
  }

  bool get _isBottom {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      return true;
    }
    return false;
  }

  void _onScroll() {
    if (_isBottom) {
      loadNextPokemons();
    }
  }

  void loadNextPokemons() async {
    offset = offset + 10;
    context.read<PokemonsBloc>().add(OnGetPokemonsList(offset: offset));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("POKEMONES LAZY LOADING"),
      ),
      body: BlocBuilder<PokemonsBloc, PokemonsState>(
        builder: (context, state) {
          switch (state) {
            case PokemonsInitial():
            case GetPokemonsListLoading():
              return const Center(child: CircularProgressIndicator());

            case GetPokemonsError():
              return const Center(
                child: Text("HUBO UN ERROR"),
              );

            case GetPokemonsSuccess():
              return Center(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount:
                      state.pokemonList.length + (state.isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.pokemonList.length) {
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ));
                    }
                    final pokemon = state.pokemonList[index];
                    return PokemonCard(pokemonEntity: pokemon);
                  },
                ),
              );

            default:
              return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const SearchPokemonPage()));
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
