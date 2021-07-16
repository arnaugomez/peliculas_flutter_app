import 'package:flutter/material.dart';
import 'package:peliculas_flutter_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? "no-movie";
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(),
        SliverList(
          delegate: SliverChildListDelegate([
            _PosterAndTitle(),
            _Overview(),
            CastingCards(),
            SizedBox(height: 30)
          ]),
        )
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          "Título película",
        ),
        background: ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
          child: FadeInImage(
              placeholder: AssetImage("assets/loading.gif"),
              image: AssetImage("assets/loading.gif"),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                height: 150,
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage("https://via.placeholder.com/200x300"),
              )),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Movie Title",
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                "Original Title",
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.star_outline, size: 20, color: Colors.grey),
                  SizedBox(width: 5),
                  Text("Movie vote average", style: textTheme.caption),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        "Magna ullamco est excepteur ut ipsum exercitation occaecat duis. Velit ex occaecat et cupidatat do dolor ea nisi. Cillum commodo proident magna officia ad. Velit laborum duis reprehenderit officia esse magna veniam in. Id commodo est incididunt sit pariatur laborum qui fugiat amet Lorem irure do laboris exercitation. Ullamco voluptate pariatur commodo deserunt non ex nostrud. Ullamco irure est tempor dolor reprehenderit officia eiusmod consectetur sit.",
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
