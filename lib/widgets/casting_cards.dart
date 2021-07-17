import 'package:flutter/material.dart';
import 'package:peliculas_flutter_app/models/models.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({Key? key, required this.movie}) : super(key: key);
  final Result movie;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 180,
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return _CastingCard();
          },
        ));
  }
}

class _CastingCard extends StatelessWidget {
  const _CastingCard({Key? key}) : super(key: key);

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
                    image: NetworkImage("https://via.placeholder.com/200x300"),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(height: 5),
            Text(
              'Actor Name',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
