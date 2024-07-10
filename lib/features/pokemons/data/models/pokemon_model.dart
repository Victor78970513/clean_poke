import 'package:pokemon_clean_arquitecture/features/pokemons/domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  PokemonModel({
    required super.id,
    required super.name,
    required super.image,
    required super.abilities,
  });
  factory PokemonModel.fromListJson(Map<String, dynamic> json) {
    List<String> abilities = (json['abilities'] as List)
        .map((ability) => ability['ability']['name'] as String)
        .toList();

    return PokemonModel(
      id: json['id'],
      name: json['name'],
      image: json['sprites']['front_default'],
      abilities: abilities,
    );
  }

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    List<String> abilities = (json['abilities'] as List)
        .map((ability) => ability['ability']['name'] as String)
        .toList();

    return PokemonModel(
      id: json['id'],
      name: json['name'],
      image: json['sprites']['other']['official-artwork']['front_default'],
      abilities: abilities,
    );
  }
}
