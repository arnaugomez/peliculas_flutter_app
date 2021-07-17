import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:peliculas_flutter_app/models/models.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  final List<Result> movies;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (this.movies.length == 0) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.55,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final placeholder = AssetImage('./assets/no-image.jpg');
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      height: size.height * 0.55,
      width: double.infinity,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.7,
        itemHeight: double.infinity,
        itemBuilder: (_, int index) {
          final movie = movies[index];

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: "movie-instance"),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: placeholder,
                  image: NetworkImage(movie.posterUrl),
                  fit: BoxFit.cover,
                )),
          );
        },
      ),
    );
  }
}
