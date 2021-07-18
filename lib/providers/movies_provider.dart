import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_flutter_app/helpers/debouncer.dart';
import 'package:peliculas_flutter_app/models/now_playing_response.dart';
import 'package:peliculas_flutter_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  static const String _baseUrl = "api.themoviedb.org";
  static const String _apiKey = "317cdea38f609f00128ea9d040e3e12c";
  static const String _language = "es-ES";

  List<Result> onDisplayMovies = [];
  List<Result> popularMovies = [];
  int _onDisplayPage = 1;
  int _popularPage = 1;
  bool isGettingPopularMovies = false;

  Map<int, List<Cast>> moviesCast = {};

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));
  final StreamController<List<Result>> suggestionStreamController =
      new StreamController.broadcast();

  MoviesProvider() {
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Stream<List<Result>> get suggestionStream =>
      this.suggestionStreamController.stream;
  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = "";
    debouncer.onValue = (value) async {
      final results = await this.searchMovies(value);
      this.suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      debouncer.value = searchTerm;
    });
    Future.delayed(Duration(milliseconds: 301)).then((value) => timer.cancel());
  }

  Future<String> _getJsonData(String route, [int page = 1]) async {
    final url = Uri.https(_baseUrl, route, {
      "api_key": _apiKey,
      'language': _language,
      'page': "$page",
    });

    var response = await http.get(url);
    if (response.statusCode != 200) {
      print("An error occurred. Server status is ${response.statusCode}");
    }
    return response.body;
  }

  void getOnDisplayMovies() async {
    NowPlayingResponse nowPlayingResponse = NowPlayingResponse.fromJson(
        await _getJsonData("3/movie/now_playing", _onDisplayPage));
    onDisplayMovies = [...onDisplayMovies, ...nowPlayingResponse.results];
    _onDisplayPage++;
    notifyListeners();
  }

  void getPopularMovies() async {
    if (!isGettingPopularMovies) {
      isGettingPopularMovies = true;
      final popularResponse = PopularResponse.fromJson(
          await _getJsonData('3/movie/popular', _popularPage));
      popularMovies = [...popularMovies, ...popularResponse.results];
      _popularPage++;
      notifyListeners();
      isGettingPopularMovies = false;
    }
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    List<Cast>? list = moviesCast[movieId];
    if (list != null) {
      return list;
    }
    final cast =
        CreditsResponse.fromJson(await _getJsonData("3/movie/$movieId/credits"))
            .cast;
    moviesCast[movieId] = cast;
    return cast;
  }

  Future<List<Result>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, "3/search/movie", {
      "api_key": _apiKey,
      'language': _language,
      'query': query,
    });
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }
}
