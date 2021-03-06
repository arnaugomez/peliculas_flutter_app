import 'package:flutter/material.dart';
import 'package:peliculas_flutter_app/providers/movies_provider.dart';
import 'package:peliculas_flutter_app/search/search_delegate.dart';
import 'package:peliculas_flutter_app/widgets/card_swiper.dart';
import 'package:peliculas_flutter_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          title: Text("Películas en cines"),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: Icon(Icons.search_outlined),
            )
          ],
        ),
        body: Column(children: [
          CardSwiper(
            movies: moviesProvider.onDisplayMovies,
          ),
          MovieSlider(
            movies: moviesProvider.popularMovies,
            title: "Películas populares",
            onNextPage: moviesProvider.getPopularMovies,
          )
        ]));
  }
}
