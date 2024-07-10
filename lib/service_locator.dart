import 'package:get_it/get_it.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/data/datasources/pokemons_remote_data_source.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/data/repository/pokemons_repository_impl.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/domain/repository/pokemons_repository.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/domain/use_cases/get_pokemons.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/domain/use_cases/search_pokemon.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/presentation/bloc/pokemons_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initPokemons();
}

void _initPokemons() {
  serviceLocator.registerFactory<PokemonsBloc>(() => PokemonsBloc(
        getPokemonListUseCase: serviceLocator<GetPokemonListUseCase>(),
        searchPokemonUseCase: serviceLocator<SearchPokemonUseCase>(),
      ));

  serviceLocator.registerLazySingleton<GetPokemonListUseCase>(
      () => GetPokemonListUseCase(pokemonListRepository: serviceLocator()));
  serviceLocator.registerLazySingleton<SearchPokemonUseCase>(
      () => SearchPokemonUseCase(pokemonsRepository: serviceLocator()));

  serviceLocator.registerLazySingleton<PokemonsRepository>(
      () => PokemonsRepositoryImpl(pokemonsRemoteDataSource: serviceLocator()));

  serviceLocator.registerLazySingleton<PokemonsRemoteDataSource>(
      () => PokemonsRemoteDatasourceImpl());
}
