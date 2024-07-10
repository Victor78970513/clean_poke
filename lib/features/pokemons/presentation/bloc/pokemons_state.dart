part of 'pokemons_bloc.dart';

@immutable
sealed class PokemonsState {}

final class PokemonsInitial extends PokemonsState {}

final class GetPokemonsListLoading extends PokemonsState {}

final class GetPokemonsSuccess extends PokemonsState {
  final List<PokemonEntity> pokemonList;
  final bool isLoadingMore;

  GetPokemonsSuccess({required this.pokemonList, this.isLoadingMore = false});
}

final class GetPokemonsError extends PokemonsState {
  final Failure failure;

  GetPokemonsError({required this.failure});
}

//

final class SearchPokemonLoading extends PokemonsState {}

final class SearchPokemonSuccess extends PokemonsState {
  final PokemonEntity pokemon;

  SearchPokemonSuccess({required this.pokemon});
}

final class SearchPokemonError extends PokemonsState {
  final Failure failure;

  SearchPokemonError({required this.failure});
}
