import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pokemon_clean_arquitecture/core/error/failure.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/data/datasources/pokemons_remote_data_source.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/domain/entities/pokemon_entity.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/domain/repository/pokemons_repository.dart';

class PokemonsRepositoryImpl implements PokemonsRepository {
  final PokemonsRemoteDataSource pokemonsRemoteDataSource;

  PokemonsRepositoryImpl({required this.pokemonsRemoteDataSource});

  @override
  Future<Either<ServerFailure, List<PokemonEntity>>> getPokemons(
      {required int offset}) async {
    try {
      final response =
          await pokemonsRemoteDataSource.getPokemons(offset: offset);
      return Right(response);
    } on DioException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, PokemonEntity>> searchPokemon(
      {required String query}) async {
    try {
      final response =
          await pokemonsRemoteDataSource.searchPokemon(query: query);
      return Right(response);
    } on DioException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
