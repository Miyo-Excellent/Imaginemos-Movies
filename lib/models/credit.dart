// To parse this JSON data, do
//
//     final credits = creditsFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class Credits {
  Credits({
    @required this.id,
    @required this.cast,
    @required this.crew,
  });

  final int id;
  final List<Cast> cast;
  final List<Crew> crew;

  Credits copyWith({
    int id,
    List<Cast> cast,
    List<Crew> crew,
  }) =>
      Credits(
        id: id ?? this.id,
        cast: cast ?? this.cast,
        crew: crew ?? this.crew,
      );

  factory Credits.fromJson(String str) => Credits.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Credits.fromMap(Map<String, dynamic> json) => Credits(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
        crew: List<Crew>.from(json["crew"].map((x) => Crew.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toMap())),
        "crew": List<dynamic>.from(crew.map((x) => x.toMap())),
      };
}

class Cast {
  Cast({
    @required this.castId,
    @required this.character,
    @required this.creditId,
    @required this.gender,
    @required this.id,
    @required this.name,
    @required this.order,
    @required this.profilePath,
  });

  final int castId;
  final String character;
  final String creditId;
  final int gender;
  final int id;
  final String name;
  final int order;
  final String profilePath;

  Cast copyWith({
    int castId,
    String character,
    String creditId,
    int gender,
    int id,
    String name,
    int order,
    String profilePath,
  }) =>
      Cast(
        castId: castId ?? this.castId,
        character: character ?? this.character,
        creditId: creditId ?? this.creditId,
        gender: gender ?? this.gender,
        id: id ?? this.id,
        name: name ?? this.name,
        order: order ?? this.order,
        profilePath: profilePath ?? this.profilePath,
      );

  factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        gender: json["gender"],
        id: json["id"],
        name: json["name"],
        order: json["order"],
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
      );

  Map<String, dynamic> toMap() => {
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "gender": gender,
        "id": id,
        "name": name,
        "order": order,
        "profile_path": profilePath == null ? null : profilePath,
      };

  String getProfile() => profilePath == null
      ? 'https://res.cloudinary.com/excellents-bros/image/upload/v1599424651/Works%20Tests/assets/images/not_found_kf6fug.webp'
      : 'https://image.tmdb.org/t/p/w500/$profilePath';
}

class Crew {
  Crew({
    @required this.creditId,
    @required this.department,
    @required this.gender,
    @required this.id,
    @required this.job,
    @required this.name,
    @required this.profilePath,
  });

  final String creditId;
  final String department;
  final int gender;
  final int id;
  final String job;
  final String name;
  final String profilePath;

  Crew copyWith({
    String creditId,
    String department,
    int gender,
    int id,
    String job,
    String name,
    String profilePath,
  }) =>
      Crew(
        creditId: creditId ?? this.creditId,
        department: department ?? this.department,
        gender: gender ?? this.gender,
        id: id ?? this.id,
        job: job ?? this.job,
        name: name ?? this.name,
        profilePath: profilePath ?? this.profilePath,
      );

  factory Crew.fromJson(String str) => Crew.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Crew.fromMap(Map<String, dynamic> json) => Crew(
        creditId: json["credit_id"],
        department: json["department"],
        gender: json["gender"],
        id: json["id"],
        job: json["job"],
        name: json["name"],
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
      );

  Map<String, dynamic> toMap() => {
        "credit_id": creditId,
        "department": department,
        "gender": gender,
        "id": id,
        "job": job,
        "name": name,
        "profile_path": profilePath == null ? null : profilePath,
      };

  String getProfile() => profilePath == null
      ? 'https://res.cloudinary.com/excellents-bros/image/upload/v1599424651/Works%20Tests/assets/images/not_found_kf6fug.webp'
      : 'https://image.tmdb.org/t/p/w500/$profilePath';
}
