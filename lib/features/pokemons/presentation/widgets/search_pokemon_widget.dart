import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/presentation/bloc/pokemons_bloc.dart';

class SearchPokemonWidget extends StatelessWidget {
  final TextEditingController controller;
  const SearchPokemonWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 3, color: Colors.black),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Ingresa el id o el nombre del pokemon"),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              context
                  .read<PokemonsBloc>()
                  .add(OnSearchPokemon(query: controller.text));
            },
            child: const Text("BUSCAR")),
      ],
    );
  }
}
