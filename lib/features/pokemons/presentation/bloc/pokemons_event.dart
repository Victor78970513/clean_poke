part of 'pokemons_bloc.dart';

@immutable
sealed class PokemonsEvent {}

final class OnGetPokemonsList extends PokemonsEvent {
  final int offset;

  OnGetPokemonsList({required this.offset});
}

final class OnSearchPokemon extends PokemonsEvent {
  final String query;

  OnSearchPokemon({required this.query});
}
