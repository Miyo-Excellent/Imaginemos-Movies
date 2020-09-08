// To parse this JSON data, do
//
//     final releaseDate = releaseDateFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class ReleaseDates {
  ReleaseDates({
    @required this.id,
    @required this.results,
  });

  final int id;
  final List<ReleaseDate> results;

  ReleaseDates copyWith({
    int id,
    List<ReleaseDate> results,
  }) =>
      ReleaseDates(
        id: id ?? this.id,
        results: results ?? this.results,
      );

  factory ReleaseDates.fromJson(String str) =>
      ReleaseDates.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReleaseDates.fromMap(Map<String, dynamic> json) => ReleaseDates(
        id: json["id"],
        results:
            List<ReleaseDate>.from(json["results"].map((x) => ReleaseDate.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class ReleaseDate {
  ReleaseDate({
    @required this.iso31661,
    @required this.releaseDates,
  });

  final String iso31661;
  final List<ReleaseDateElement> releaseDates;

  ReleaseDate copyWith({
    String iso31661,
    List<ReleaseDateElement> releaseDates,
  }) =>
      ReleaseDate(
        iso31661: iso31661 ?? this.iso31661,
        releaseDates: releaseDates ?? this.releaseDates,
      );

  factory ReleaseDate.fromJson(String str) => ReleaseDate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReleaseDate.fromMap(Map<String, dynamic> json) => ReleaseDate(
        iso31661: json["iso_3166_1"],
        releaseDates: List<ReleaseDateElement>.from(
            json["release_dates"].map((x) => ReleaseDateElement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "iso_3166_1": iso31661,
        "release_dates": List<dynamic>.from(releaseDates.map((x) => x.toMap())),
      };
}

class ReleaseDateElement {
  ReleaseDateElement({
    @required this.certification,
    @required this.iso6391,
    @required this.releaseDate,
    @required this.type,
  });

  final String certification;
  final String iso6391;
  final DateTime releaseDate;
  final int type;

  ReleaseDateElement copyWith({
    String certification,
    String iso6391,
    DateTime releaseDate,
    int type,
  }) =>
      ReleaseDateElement(
        certification: certification ?? this.certification,
        iso6391: iso6391 ?? this.iso6391,
        releaseDate: releaseDate ?? this.releaseDate,
        type: type ?? this.type,
      );

  factory ReleaseDateElement.fromJson(String str) =>
      ReleaseDateElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReleaseDateElement.fromMap(Map<String, dynamic> json) =>
      ReleaseDateElement(
        certification: json["certification"],
        iso6391: json["iso_639_1"],
        releaseDate: DateTime.parse(json["release_date"]),
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "certification": certification,
        "iso_639_1": iso6391,
        "release_date": releaseDate.toIso8601String(),
        "type": type,
      };
}
