import 'package:flutter/material.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/domain/entities/pokemon_entity.dart';

class PokemonCard extends StatelessWidget {
  final PokemonEntity pokemonEntity;
  const PokemonCard({super.key, required this.pokemonEntity});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${pokemonEntity.id.toString().padLeft(3, '0')}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      pokemonEntity.name.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                FadeInImage(
                  placeholder: const AssetImage("assets/images/no-image.jpg"),
                  image: NetworkImage(pokemonEntity.image),
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Habilidades",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: pokemonEntity.abilities.map((ability) {
                      return Chip(
                        label: Text(ability,
                            style: const TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blueAccent,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
