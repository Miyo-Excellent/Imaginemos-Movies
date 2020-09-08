// To parse this JSON data, do
//
//     final video = videoFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class Videos {
  Videos({
    @required this.id,
    @required this.results,
  });

  final int id;
  final List<Video> results;

  Videos copyWith({
    int id,
    List<Video> results,
  }) =>
      Videos(
        id: id ?? this.id,
        results: results ?? this.results,
      );

  factory Videos.fromJson(String str) => Videos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Videos.fromMap(Map<String, dynamic> json) => Videos(
        id: json["id"],
        results:
            List<Video>.from(json["results"].map((x) => Video.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Video {
  Video({
    @required this.id,
    @required this.iso6391,
    @required this.iso31661,
    @required this.key,
    @required this.name,
    @required this.site,
    @required this.size,
    @required this.type,
  });

  final String id;
  final String iso6391;
  final String iso31661;
  final String key;
  final String name;
  final String site;
  final int size;
  final String type;

  Video copyWith({
    String id,
    String iso6391,
    String iso31661,
    String key,
    String name,
    String site,
    int size,
    String type,
  }) =>
      Video(
        id: id ?? this.id,
        iso6391: iso6391 ?? this.iso6391,
        iso31661: iso31661 ?? this.iso31661,
        key: key ?? this.key,
        name: name ?? this.name,
        site: site ?? this.site,
        size: size ?? this.size,
        type: type ?? this.type,
      );

  factory Video.fromJson(String str) => Video.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Video.fromMap(Map<String, dynamic> json) => Video(
        id: json["id"],
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        key: json["key"],
        name: json["name"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "key": key,
        "name": name,
        "site": site,
        "size": size,
        "type": type,
      };
}
