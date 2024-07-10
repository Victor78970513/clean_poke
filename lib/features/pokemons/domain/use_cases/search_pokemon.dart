import 'package:dartz/dartz.dart';
import 'package:pokemon_clean_arquitecture/core/error/failure.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/domain/entities/pokemon_entity.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/domain/repository/pokemons_repository.dart';

class SearchPokemonUseCase {
  final PokemonsRepository pokemonsRepository;

  SearchPokemonUseCase({required this.pokemonsRepository});

  Future<Either<Failure, PokemonEntity>> call({required String query}) {
    return pokemonsRepository.searchPokemon(query: query);
  }
}
