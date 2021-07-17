import 'package:flutter/material.dart';
import 'package:peliculas_flutter_app/models/models.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({Key? key, required this.movies, this.title})
      : super(key: key);

  final List<Result> movies;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null)
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Text(
                    this.title!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            _PopularMovieList(movies: movies)
          ],
        ),
      ),
    );
  }
}

class _PopularMovieList extends StatelessWidget {
  const _PopularMovieList({Key? key, required this.movies}) : super(key: key);
  final List<Result> movies;

  @override
  Widget build(BuildContext context) {
    final placeholder = AssetImage('./assets/no-image.jpg');
    return Expanded(
        child: ListView.builder(
            itemCount: movies.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'details',
                        arguments: "movie-instance"),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                            width: 130,
                            height: double.infinity,
                            color: Colors.grey[900],
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: FadeInImage(
                                    placeholder: placeholder,
                                    image:
                                        NetworkImage(movies[index].posterUrl),
                                    fit: BoxFit.cover,
                                  )),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      movies[index].title,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ])))))));
  }
}
