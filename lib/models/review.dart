// To parse this JSON data, do
//
//     final reviews = reviewsFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class Reviews {
  Reviews({
    @required this.id,
    @required this.page,
    @required this.results,
    @required this.totalPages,
    @required this.totalResults,
  });

  final int id;
  final int page;
  final List<Review> results;
  final int totalPages;
  final int totalResults;

  Reviews copyWith({
    int id,
    int page,
    List<Review> results,
    int totalPages,
    int totalResults,
  }) =>
      Reviews(
        id: id ?? this.id,
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory Reviews.fromJson(String str) => Reviews.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Reviews.fromMap(Map<String, dynamic> json) => Reviews(
        id: json["id"],
        page: json["page"],
        results:
            List<Review>.from(json["results"].map((x) => Review.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Review {
  Review({
    @required this.id,
    @required this.author,
    @required this.content,
    @required this.url,
  });

  final String id;
  final String author;
  final String content;
  final String url;

  Review copyWith({
    String id,
    String author,
    String content,
    String url,
  }) =>
      Review(
        id: id ?? this.id,
        author: author ?? this.author,
        content: content ?? this.content,
        url: url ?? this.url,
      );

  factory Review.fromJson(String str) => Review.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Review.fromMap(Map<String, dynamic> json) => Review(
        id: json["id"],
        author: json["author"],
        content: json["content"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "author": author,
        "content": content,
        "url": url,
      };
}
