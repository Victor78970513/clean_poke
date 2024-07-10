class PokemonEntity {
  final int id;
  final String name;
  final String image;
  final List<String> abilities;

  PokemonEntity({
    required this.name,
    required this.image,
    required this.id,
    required this.abilities,
  });
}
