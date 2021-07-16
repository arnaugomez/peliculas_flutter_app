import 'package:flutter/material.dart';

class MoviesProvider extends ChangeNotifier{
  MoviesProvider() {
    print("Movies provider inicializado");
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    print("Hello world here are your movies");
  }

}