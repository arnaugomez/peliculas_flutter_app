import 'package:flutter/material.dart';
import 'package:peliculas_flutter_app/models/models.dart';

class MovieSlider extends StatefulWidget {
  const MovieSlider(
      {Key? key, required this.movies, this.title, required this.onNextPage})
      : super(key: key);

  final List<Result> movies;
  final String? title;
  final Function onNextPage;

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.title != null)
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Text(
                    this.widget.title!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            _PopularMovieList(
              movies: widget.movies,
              scrollController: scrollController,
            )
          ],
        ),
      ),
    );
  }
}

class _PopularMovieList extends StatelessWidget {
  const _PopularMovieList(
      {Key? key, required this.movies, required this.scrollController})
      : super(key: key);
  final List<Result> movies;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            controller: scrollController,
            itemCount: movies.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'details',
                        arguments: movies[index]),
                    child: _MoviePoster(movie: movies[index])))));
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Result movie;

  @override
  Widget build(BuildContext context) {
    final placeholder = AssetImage('./assets/no-image.jpg');
    return ClipRRect(
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
                    image: NetworkImage(movie.posterUrl),
                    fit: BoxFit.cover,
                  )),
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      child: Text(
                        movie.title,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ))
                ])));
  }
}
