import 'package:dartz/dartz.dart';
import 'package:pokemon_clean_arquitecture/core/error/failure.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/domain/entities/pokemon_entity.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/domain/repository/pokemons_repository.dart';

class GetPokemonListUseCase {
  final PokemonsRepository pokemonListRepository;

  GetPokemonListUseCase({required this.pokemonListRepository});

  Future<Either<Failure, List<PokemonEntity>>> call({required int offset}) {
    return pokemonListRepository.getPokemons(offset: offset);
  }
}
