import 'package:flutter/material.dart';
import 'package:peliculas_flutter_app/models/models.dart';
import 'package:peliculas_flutter_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => query = "",
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) => Text("Build results");

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return NoResultsIndicator();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context);
    return FutureBuilder(
        future: moviesProvider.searchMovies(query),
        builder: (BuildContext context, AsyncSnapshot<List<Result>> snapshot) {
          if (!snapshot.hasData || snapshot.data!.length == 0)
            return NoResultsIndicator();

          final movies = snapshot.data!;

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) =>
                MovieListItem(movie: movies[index]),
          );
        });
  }
}

class MovieListItem extends StatelessWidget {
  const MovieListItem({Key? key, required this.movie}) : super(key: key);
  final Result movie;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage(movie.posterUrl),
            fit: BoxFit.contain,
          ),
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      trailing: Icon(Icons.chevron_right),
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
    );
  }
}

class NoResultsIndicator extends StatelessWidget {
  const NoResultsIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Icon(
      Icons.movie_creation_outlined,
      color: Colors.black38,
      size: 100,
    )));
  }
}
