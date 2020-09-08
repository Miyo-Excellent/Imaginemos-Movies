// To parse this JSON data, do
//
//     final translation = translationFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class Translations {
  Translations({
    @required this.id,
    @required this.translations,
  });

  final int id;
  final List<Translation> translations;

  Translations copyWith({
    int id,
    List<Translation> translations,
  }) =>
      Translations(
        id: id ?? this.id,
        translations: translations ?? this.translations,
      );

  factory Translations.fromJson(String str) =>
      Translations.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Translations.fromMap(Map<String, dynamic> json) => Translations(
        id: json["id"],
        translations: List<Translation>.from(
            json["translations"].map((x) => Translation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "translations": List<dynamic>.from(translations.map((x) => x.toMap())),
      };
}

class Translation {
  Translation({
    @required this.iso31661,
    @required this.iso6391,
    @required this.name,
    @required this.englishName,
    @required this.data,
  });

  final String iso31661;
  final String iso6391;
  final String name;
  final String englishName;
  final Data data;

  Translation copyWith({
    String iso31661,
    String iso6391,
    String name,
    String englishName,
    Data data,
  }) =>
      Translation(
        iso31661: iso31661 ?? this.iso31661,
        iso6391: iso6391 ?? this.iso6391,
        name: name ?? this.name,
        englishName: englishName ?? this.englishName,
        data: data ?? this.data,
      );

  factory Translation.fromJson(String str) =>
      Translation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Translation.fromMap(Map<String, dynamic> json) =>
      Translation(
        iso31661: json["iso_3166_1"],
        iso6391: json["iso_639_1"],
        name: json["name"],
        englishName: json["english_name"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "iso_3166_1": iso31661,
        "iso_639_1": iso6391,
        "name": name,
        "english_name": englishName,
        "data": data.toMap(),
      };
}

class Data {
  Data({
    @required this.title,
    @required this.overview,
    @required this.homepage,
  });

  final String title;
  final String overview;
  final String homepage;

  Data copyWith({
    String title,
    String overview,
    String homepage,
  }) =>
      Data(
        title: title ?? this.title,
        overview: overview ?? this.overview,
        homepage: homepage ?? this.homepage,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        title: json["title"],
        overview: json["overview"],
        homepage: json["homepage"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "overview": overview,
        "homepage": homepage,
      };
}
