// To parse this JSON data, do
//
//     final keyword = keywordFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class Keywords {
  Keywords({
    @required this.id,
    @required this.keywords,
  });

  final int id;
  final List<Keyword> keywords;

  Keywords copyWith({
    int id,
    List<Keyword> keywords,
  }) =>
      Keywords(
        id: id ?? this.id,
        keywords: keywords ?? this.keywords,
      );

  factory Keywords.fromJson(String str) => Keywords.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Keywords.fromMap(Map<String, dynamic> json) => Keywords(
        id: json["id"],
        keywords:
            List<Keyword>.from(json["keywords"].map((x) => Keyword.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "keywords": List<dynamic>.from(keywords.map((x) => x.toMap())),
      };
}

class Keyword {
  Keyword({
    @required this.id,
    @required this.name,
  });

  final int id;
  final String name;

  Keyword copyWith({
    int id,
    String name,
  }) =>
      Keyword(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Keyword.fromJson(String str) => Keyword.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Keyword.fromMap(Map<String, dynamic> json) => Keyword(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
