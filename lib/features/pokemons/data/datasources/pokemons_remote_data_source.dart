import 'package:dio/dio.dart';
import 'package:pokemon_clean_arquitecture/core/error/failure.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/data/models/pokemon_model.dart';

abstract class PokemonsRemoteDataSource {
  Future<List<PokemonModel>> getPokemons({required int offset});
  Future<PokemonModel> searchPokemon({required String query});
}

class PokemonsRemoteDatasourceImpl implements PokemonsRemoteDataSource {
  final Dio dio = Dio();
  @override
  Future<List<PokemonModel>> getPokemons({required int offset}) async {
    final List<PokemonModel> pokemons = [];
    try {
      final response = await dio.get(
        "https://pokeapi.co/api/v2/pokemon",
        queryParameters: {
          "limit": 10,
          "offset": offset,
        },
      );
      final results = response.data['results'];
      for (final result in results) {
        final pokemonResponse = await dio.get(result['url']);
        pokemons.add(PokemonModel.fromListJson(pokemonResponse.data));
      }
      return pokemons;
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<PokemonModel> searchPokemon({required String query}) async {
    try {
      final response = await dio.get(
        "https://pokeapi.co/api/v2/pokemon/${query}",
      );
      return PokemonModel.fromJson(response.data);
    } catch (e) {
      throw ServerFailure();
    }
  }
}
