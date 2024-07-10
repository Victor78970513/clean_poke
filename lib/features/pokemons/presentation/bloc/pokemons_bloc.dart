import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_clean_arquitecture/core/error/failure.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/domain/entities/pokemon_entity.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/domain/use_cases/get_pokemons.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/domain/use_cases/search_pokemon.dart';

part 'pokemons_event.dart';
part 'pokemons_state.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  final GetPokemonListUseCase _getPokemonListUseCase;
  final SearchPokemonUseCase _searchPokemonUseCase;
  PokemonsBloc({
    required GetPokemonListUseCase getPokemonListUseCase,
    required SearchPokemonUseCase searchPokemonUseCase,
  })  : _getPokemonListUseCase = getPokemonListUseCase,
        _searchPokemonUseCase = searchPokemonUseCase,
        super(PokemonsInitial()) {
    on<OnGetPokemonsList>(_onGetPokemonsList);
    on<OnSearchPokemon>(_onSearchPokemon);
  }

  FutureOr<void> _onGetPokemonsList(
      OnGetPokemonsList event, Emitter<PokemonsState> emit) async {
    if (state is GetPokemonsSuccess) {
      emit(GetPokemonsSuccess(
          pokemonList: (state as GetPokemonsSuccess).pokemonList,
          isLoadingMore: true));
    } else {
      emit(GetPokemonsListLoading());
    }

    final response = await _getPokemonListUseCase(offset: event.offset);
    response.fold(
      (failure) => emit(GetPokemonsError(failure: failure)),
      (pokemonList) {
        final List<PokemonEntity> currentPokemonList =
            state is GetPokemonsSuccess
                ? (state as GetPokemonsSuccess).pokemonList
                : [];
        emit(GetPokemonsSuccess(
            pokemonList: [...currentPokemonList, ...pokemonList]));
      },
    );
  }

  FutureOr<void> _onSearchPokemon(
      OnSearchPokemon event, Emitter<PokemonsState> emit) async {
    emit(SearchPokemonLoading());
    final response = await _searchPokemonUseCase(query: event.query);
    response.fold(
      (failure) => emit(SearchPokemonError(failure: failure)),
      (right) => emit(SearchPokemonSuccess(pokemon: right)),
    );
  }
}
