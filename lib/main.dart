import 'package:flutter/material.dart';
import 'package:peliculas_flutter_app/helpers/create_widget_builder.dart';
import 'package:peliculas_flutter_app/providers/movies_provider.dart';
import 'package:peliculas_flutter_app/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class AppState extends StatelessWidget {
  const AppState({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        )
      ],
      child: this.child,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppState(
      child: MaterialApp(
        title: 'Películas',
        initialRoute: 'home',
        debugShowCheckedModeBanner: false,
        routes: {
          'home': createWidgetBuilder(HomeScreen()),
          'details': createWidgetBuilder(DetailsScreen())
        },
        theme: ThemeData.light().copyWith(
            appBarTheme: AppBarTheme(
          color: Colors.indigo[800],
        )),
      ),
    );
  }
}
