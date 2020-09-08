// To parse this JSON data, do
//
//     final latest = latestFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class Latest {
  Latest({
    @required this.adult,
    @required this.backdropPath,
    @required this.belongsToCollection,
    @required this.budget,
    @required this.genres,
    @required this.homepage,
    @required this.id,
    @required this.imdbId,
    @required this.originalLanguage,
    @required this.originalTitle,
    @required this.overview,
    @required this.popularity,
    @required this.posterPath,
    @required this.productionCompanies,
    @required this.productionCountries,
    @required this.releaseDate,
    @required this.revenue,
    @required this.runtime,
    @required this.spokenLanguages,
    @required this.status,
    @required this.tagline,
    @required this.title,
    @required this.video,
    @required this.voteAverage,
    @required this.voteCount,
  });

  final bool adult;
  final dynamic backdropPath;
  final dynamic belongsToCollection;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final int popularity;
  final String posterPath;
  final List<dynamic> productionCompanies;
  final List<dynamic> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<dynamic> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final int voteAverage;
  final int voteCount;

  Latest copyWith({
    bool adult,
    dynamic backdropPath,
    dynamic belongsToCollection,
    int budget,
    List<Genre> genres,
    String homepage,
    int id,
    String imdbId,
    String originalLanguage,
    String originalTitle,
    String overview,
    int popularity,
    String posterPath,
    List<dynamic> productionCompanies,
    List<dynamic> productionCountries,
    String releaseDate,
    int revenue,
    int runtime,
    List<dynamic> spokenLanguages,
    String status,
    String tagline,
    String title,
    bool video,
    int voteAverage,
    int voteCount,
  }) =>
      Latest(
        adult: adult ?? this.adult,
        backdropPath: backdropPath ?? this.backdropPath,
        belongsToCollection: belongsToCollection ?? this.belongsToCollection,
        budget: budget ?? this.budget,
        genres: genres ?? this.genres,
        homepage: homepage ?? this.homepage,
        id: id ?? this.id,
        imdbId: imdbId ?? this.imdbId,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        posterPath: posterPath ?? this.posterPath,
        productionCompanies: productionCompanies ?? this.productionCompanies,
        productionCountries: productionCountries ?? this.productionCountries,
        releaseDate: releaseDate ?? this.releaseDate,
        revenue: revenue ?? this.revenue,
        runtime: runtime ?? this.runtime,
        spokenLanguages: spokenLanguages ?? this.spokenLanguages,
        status: status ?? this.status,
        tagline: tagline ?? this.tagline,
        title: title ?? this.title,
        video: video ?? this.video,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
      );

  factory Latest.fromJson(String str) => Latest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Latest.fromMap(Map<String, dynamic> json) => Latest(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"],
        budget: json["budget"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"] is int
            ? json["popularity"]
            : json["popularity"].toInt(),
        posterPath: json["poster_path"],
        productionCompanies:
            List<dynamic>.from(json["production_companies"].map((x) => x)),
        productionCountries:
            List<dynamic>.from(json["production_countries"].map((x) => x)),
        releaseDate: json["release_date"],
        revenue: json["revenue"],
        runtime: json["runtime"],
        spokenLanguages:
            List<dynamic>.from(json["spoken_languages"].map((x) => x)),
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"] is int
            ? json["vote_average"]
            : json["vote_average"].toInt(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toMap() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "belongs_to_collection": belongsToCollection,
        "budget": budget,
        "genres": List<dynamic>.from(genres.map((x) => x.toMap())),
        "homepage": homepage,
        "id": id,
        "imdb_id": imdbId,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies":
            List<dynamic>.from(productionCompanies.map((x) => x)),
        "production_countries":
            List<dynamic>.from(productionCountries.map((x) => x)),
        "release_date": releaseDate,
        "revenue": revenue,
        "runtime": runtime,
        "spoken_languages": List<dynamic>.from(spokenLanguages.map((x) => x)),
        "status": status,
        "tagline": tagline,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

class Genre {
  Genre({
    @required this.id,
    @required this.name,
  });

  final int id;
  final String name;

  Genre copyWith({
    int id,
    String name,
  }) =>
      Genre(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Genre.fromJson(String str) => Genre.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Genre.fromMap(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
