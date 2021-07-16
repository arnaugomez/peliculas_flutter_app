import 'package:flutter/material.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeholder = AssetImage('./assets/no-image.jpg');
    final image = NetworkImage('https://via.placeholder.com/300x400');
    return Expanded(
      child: Container(
        width: double.infinity,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Text(
                  "Populares",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) => Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, 'details', arguments: "movie-instance"),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              clipBehavior: Clip.antiAlias,
                              child: Container(
                                width: 130,
                                height: double.infinity,
                                color: Colors.grey[300],
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                        child: FadeInImage(
                                      placeholder: placeholder,
                                      image: image,
                                      fit: BoxFit.cover,
                                    )),
                                    Container(
                                      height: 40,
                                      width: double.infinity,
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Star Wars: El retorno del nuevo jedai silvestre de Montecristo",
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )))
          ],
        ),
      ),
    );
  }
}
