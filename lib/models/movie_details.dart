// To parse this JSON data, do
//
//     final details = detailsFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class MovieDetails {
  MovieDetails({
    @required this.page,
    @required this.results,
    @required this.totalResults,
    @required this.totalPages,
  });

  final int page;
  final List<MovieDetail> results;
  final int totalResults;
  final int totalPages;

  MovieDetails copyWith({
    int page,
    List<MovieDetail> results,
    int totalResults,
    int totalPages,
  }) =>
      MovieDetails(
        page: page ?? this.page,
        results: results ?? this.results,
        totalResults: totalResults ?? this.totalResults,
        totalPages: totalPages ?? this.totalPages,
      );

  factory MovieDetails.fromJson(String str) => MovieDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieDetails.fromMap(Map<String, dynamic> json) => MovieDetails(
        page: json["page"],
        results:
            List<MovieDetail>.from(json["results"].map((x) => MovieDetail.fromMap(x))),
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
        "total_results": totalResults,
        "total_pages": totalPages,
      };
}

class MovieDetail {
  MovieDetail({
    @required this.posterPath,
    @required this.adult,
    @required this.overview,
    @required this.releaseDate,
    @required this.genreIds,
    @required this.id,
    @required this.originalTitle,
    @required this.originalLanguage,
    @required this.title,
    @required this.backdropPath,
    @required this.popularity,
    @required this.voteCount,
    @required this.video,
    @required this.voteAverage,
  });

  final dynamic posterPath;
  final bool adult;
  final String overview;
  final DateTime releaseDate;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final OriginalLanguage originalLanguage;
  final String title;
  final dynamic backdropPath;
  final double popularity;
  final int voteCount;
  final bool video;
  final double voteAverage;

  MovieDetail copyWith({
    dynamic posterPath,
    bool adult,
    String overview,
    DateTime releaseDate,
    List<int> genreIds,
    int id,
    String originalTitle,
    OriginalLanguage originalLanguage,
    String title,
    dynamic backdropPath,
    double popularity,
    int voteCount,
    bool video,
    double voteAverage,
  }) =>
      MovieDetail(
        posterPath: posterPath ?? this.posterPath,
        adult: adult ?? this.adult,
        overview: overview ?? this.overview,
        releaseDate: releaseDate ?? this.releaseDate,
        genreIds: genreIds ?? this.genreIds,
        id: id ?? this.id,
        originalTitle: originalTitle ?? this.originalTitle,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        title: title ?? this.title,
        backdropPath: backdropPath ?? this.backdropPath,
        popularity: popularity ?? this.popularity,
        voteCount: voteCount ?? this.voteCount,
        video: video ?? this.video,
        voteAverage: voteAverage ?? this.voteAverage,
      );

  factory MovieDetail.fromJson(String str) => MovieDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieDetail.fromMap(Map<String, dynamic> json) => MovieDetail(
        posterPath: json["poster_path"],
        adult: json["adult"],
        overview: json["overview"],
        releaseDate: DateTime.parse(json["release_date"]),
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalTitle: json["original_title"],
        originalLanguage: originalLanguageValues.map[json["original_language"]],
        title: json["title"],
        backdropPath: json["backdrop_path"],
        popularity: json["popularity"].toDouble(),
        voteCount: json["vote_count"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "poster_path": posterPath,
        "adult": adult,
        "overview": overview,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_title": originalTitle,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "title": title,
        "backdrop_path": backdropPath,
        "popularity": popularity,
        "vote_count": voteCount,
        "video": video,
        "vote_average": voteAverage,
      };
}

enum OriginalLanguage { EN, ES }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES,
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
