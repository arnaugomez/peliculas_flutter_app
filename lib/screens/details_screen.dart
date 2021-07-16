import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? "no-movie";
    return Scaffold(
        body: CustomScrollView(
      slivers: [_CustomAppBar()],
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
        titlePadding: EdgeInsets.all(0),
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
