import 'package:flutter/material.dart';
import 'package:peliculas_flutter_app/helpers/create_widget_builder.dart';
import 'package:peliculas_flutter_app/screens/screens.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Películas',
      initialRoute: 'home',
      routes: {
        'home': createWidgetBuilder(HomeScreen()),
        'details': createWidgetBuilder(DetailsScreen())
      }
    );
  }
}