import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_flutter_app/models/now_playing_response.dart';
import 'package:peliculas_flutter_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  static const String _baseUrl = "api.themoviedb.org";
  static const String _apiKey = "317cdea38f609f00128ea9d040e3e12c";
  static const String _language = "es-ES";

  List<Result> onDisplayMovies = [];
  List<Result> popularMovies = [];

  MoviesProvider() {
    print("Movies provider inicializado");
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  void getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, "3/movie/now_playing", {
      "api_key": _apiKey,
      'language': _language,
      'page': "1",
    });

    var response = await http.get(url);
    if (response.statusCode != 200) {
      print("An error occurred. Server status is ${response.statusCode}");
    } else {
      NowPlayingResponse nowPlayingResponse =
          NowPlayingResponse.fromJson(response.body);
      onDisplayMovies = [...onDisplayMovies, ...nowPlayingResponse.results];
      notifyListeners();
    }
  }

  void getPopularMovies() async {
    var url = Uri.https(_baseUrl, "3/movie/popular", {
      "api_key": _apiKey,
      'language': _language,
      'page': "1",
    });

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }
}
