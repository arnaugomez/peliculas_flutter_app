import 'dart:convert';

import 'package:peliculas_flutter_app/models/models.dart';


class SearchResponse {
    SearchResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Result> results;
    int totalPages;
    int totalResults;

    factory SearchResponse.fromJson(String str) => SearchResponse.fromMap(json.decode(str));

    factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        page: json["page"],
        results: List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

}