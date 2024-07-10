import "package:dartz/dartz.dart";
import "package:pokemon_clean_arquitecture/core/error/failure.dart";
import "package:pokemon_clean_arquitecture/features/pokemons/domain/entities/pokemon_entity.dart";

abstract interface class PokemonsRepository {
  Future<Either<ServerFailure, List<PokemonEntity>>> getPokemons(
      {required int offset});

  Future<Either<ServerFailure, PokemonEntity>> searchPokemon(
      {required String query});
}
