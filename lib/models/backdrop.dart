// To parse this JSON data, do
//
//     final backdrop = backdropFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class Backdrops {
  Backdrops({
    @required this.id,
    @required this.backdrops,
    @required this.posters,
  });

  final int id;
  final List<Backdrop> backdrops;
  final List<Backdrop> posters;

  Backdrops copyWith({
    int id,
    List<Backdrop> backdrops,
    List<Backdrop> posters,
  }) =>
      Backdrops(
        id: id ?? this.id,
        backdrops: backdrops ?? this.backdrops,
        posters: posters ?? this.posters,
      );

  factory Backdrops.fromJson(String str) => Backdrops.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Backdrops.fromMap(Map<String, dynamic> json) => Backdrops(
        id: json["id"],
        backdrops: List<Backdrop>.from(
            json["backdrops"].map((x) => Backdrop.fromMap(x))),
        posters: List<Backdrop>.from(
            json["posters"].map((x) => Backdrop.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "backdrops": List<dynamic>.from(backdrops.map((x) => x.toMap())),
        "posters": List<dynamic>.from(posters.map((x) => x.toMap())),
      };
}

class Backdrop {
  Backdrop({
    @required this.aspectRatio,
    @required this.filePath,
    @required this.height,
    @required this.iso6391,
    @required this.voteAverage,
    @required this.voteCount,
    @required this.width,
  });

  final double aspectRatio;
  final String filePath;
  final int height;
  final String iso6391;
  final int voteAverage;
  final int voteCount;
  final int width;

  Backdrop copyWith({
    double aspectRatio,
    String filePath,
    int height,
    String iso6391,
    int voteAverage,
    int voteCount,
    int width,
  }) =>
      Backdrop(
        aspectRatio: aspectRatio ?? this.aspectRatio,
        filePath: filePath ?? this.filePath,
        height: height ?? this.height,
        iso6391: iso6391 ?? this.iso6391,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
        width: width ?? this.width,
      );

  factory Backdrop.fromJson(String str) =>
      Backdrop.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Backdrop.fromMap(Map<String, dynamic> json) => Backdrop(
        aspectRatio: json["aspect_ratio"].toDouble(),
        filePath: json["file_path"],
        height: json["height"],
        iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
        width: json["width"],
      );

  Map<String, dynamic> toMap() => {
        "aspect_ratio": aspectRatio,
        "file_path": filePath,
        "height": height,
        "iso_639_1": iso6391 == null ? null : iso6391,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "width": width,
      };
}
