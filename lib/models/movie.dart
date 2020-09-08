// To parse this JSON data, do
//
//     final movie = movieFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Movies {
  Movies({
    @required this.page,
    @required this.results,
    @required this.totalResults,
    @required this.totalPages,
  });

  final int page;
  final List<Movie> results;
  final int totalResults;
  final int totalPages;

  Movies copyWith({
    int page,
    List<Movie> results,
    int totalResults,
    int totalPages,
  }) =>
      Movies(
        page: page ?? this.page,
        results: results ?? this.results,
        totalResults: totalResults ?? this.totalResults,
        totalPages: totalPages ?? this.totalPages,
      );

  factory Movies.fromJson(String str) => Movies.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Movies.fromMap(Map<String, dynamic> json) =>
      Movies(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toMap() =>
      {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
        "total_results": totalResults,
        "total_pages": totalPages,
      };
}

class Movie {
  Movie({
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

  final String posterPath;
  final bool adult;
  final String overview;
  final String releaseDate;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String backdropPath;
  final double popularity;
  final int voteCount;
  final bool video;
  final double voteAverage;

  Movie copyWith({
    String posterPath,
    bool adult,
    String overview,
    String releaseDate,
    List<int> genreIds,
    int id,
    String originalTitle,
    String originalLanguage,
    String title,
    String backdropPath,
    double popularity,
    int voteCount,
    bool video,
    double voteAverage,
  }) =>
      Movie(
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

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Movie.fromMap(Map<String, dynamic> json) =>
      Movie(
        posterPath: json["poster_path"],
        adult: json["adult"],
        overview: json["overview"],
        releaseDate: json["release_date"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalTitle: json["original_title"],
        originalLanguage: json["original_language"],
        title: json["title"],
        backdropPath: json["backdrop_path"],
        popularity: json["popularity"].toDouble(),
        voteCount: json["vote_count"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toMap() =>
      {
        "poster_path": posterPath,
        "adult": adult,
        "overview": overview,
        "release_date": releaseDate,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_title": originalTitle,
        "original_language": originalLanguage,
        "title": title,
        "backdrop_path": backdropPath,
        "popularity": popularity,
        "vote_count": voteCount,
        "video": video,
        "vote_average": voteAverage,
      };

  String getPoster() =>
      posterPath == null
          ? 'https://res.cloudinary.com/excellents-bros/image/upload/v1599194173/Works%20Tests/assets/images/loader_tv_b0aqbx.webp'
          : 'https://image.tmdb.org/t/p/w500/$posterPath';

  String getBackdrop() =>
      backdropPath == null
          ? 'https://res.cloudinary.com/excellents-bros/image/upload/v1599194173/Works%20Tests/assets/images/loader_tv_b0aqbx.webp'
          : 'https://image.tmdb.org/t/p/w500/$backdropPath';
}
