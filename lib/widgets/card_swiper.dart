import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeholder = AssetImage('./assets/no-image.jpg');
    final image = NetworkImage('https://via.placeholder.com/300x400');
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      height: size.height * 0.55,
      width: double.infinity,
      child: Swiper(
        itemCount: 10,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.7,
        itemHeight: double.infinity,
        itemBuilder: (_, int index) {
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: "movie-instance"),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: placeholder,
                  image: image,
                  fit: BoxFit.cover,
                )),
          );
        },
      ),
    );
  }
}
