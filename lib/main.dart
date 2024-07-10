import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/presentation/bloc/pokemons_bloc.dart';
import 'package:pokemon_clean_arquitecture/features/pokemons/presentation/pages/pokemon_list_page.dart';
import 'package:pokemon_clean_arquitecture/service_locator.dart';

void main() async {
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<PokemonsBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: PokemonListPage(),
    );
  }
}
