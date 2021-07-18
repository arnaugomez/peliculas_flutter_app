import 'package:flutter/material.dart';
import 'package:peliculas_flutter_app/models/models.dart';
import 'package:peliculas_flutter_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({Key? key, required this.movieId}) : super(key: key);
  final int movieId;

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
        future: moviesProvider.getMovieCast(movieId),
        builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
          if (snapshot.hasData) {
            final List<Cast> actors = snapshot.data!;
            return Container(
                width: double.infinity,
                height: 180,
                child: ListView.builder(
                    itemCount: actors.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return _CastingCard(actor: actors[index]);
                    }));
          }
          return SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        });
  }
}

class _CastingCard extends StatelessWidget {
  const _CastingCard({Key? key, required this.actor}) : super(key: key);
  final Cast actor;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 110,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(actor.fullProfilePath),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(height: 5),
            Text(
              actor.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
