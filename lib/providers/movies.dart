import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:imaginemos_movies/models/backdrop.dart';
import 'package:imaginemos_movies/models/credit.dart';
import 'package:imaginemos_movies/models/keyword.dart';
import 'package:imaginemos_movies/models/latest.dart';
import 'package:imaginemos_movies/models/movie.dart';
import 'package:imaginemos_movies/models/movie_details.dart';
import 'package:imaginemos_movies/models/release_date.dart';
import 'package:imaginemos_movies/models/review.dart';
import 'package:imaginemos_movies/models/translation.dart';
import 'package:imaginemos_movies/models/video.dart';

class MoviesProvider {
  final String _apiKey = "77c6664896a34c14b128e5400af37e51";
  final String _url = "api.themoviedb.org";
//  final String _language = "es-ES";
  final String _language = "en-EN";

  List<Movie> handlerError({@required dynamic data}) {
    if (data['success'] != null && !data['success']) {
      print(data['status_message']);
    }

    return <Movie>[];
  }

  Latest handlerLatestError({@required dynamic data}) {
    if (data['success'] != null && !data['success']) {
      print(data['status_message']);
    }

    return null;
  }

  List<Movie> handlerSuccessSearch({@required dynamic data}) {
    final Movies movies = Movies.fromMap(data);

    return movies.results;
  }

  List<Movie> handlerSuccessMovies({@required dynamic data}) {
    final Movies movies = Movies.fromMap(data);

    return movies.results;
  }

  List<MovieDetail> handlerSuccessDetails({@required dynamic data}) =>
      MovieDetails.fromMap(data).results;

  List<Translation> handlerSuccessTranslations({@required dynamic data}) =>
      Translations.fromMap(data).translations;

  List<Review> handlerSuccessReviews({@required dynamic data}) =>
      Reviews.fromMap(data).results;

  List<ReleaseDate> handlerSuccessReleaseDate({@required dynamic data}) =>
      ReleaseDates.fromMap(data).results;

  List<Video> handlerSuccessVideos({@required dynamic data}) =>
      Videos.fromMap(data).results;

  List<Backdrop> handlerSuccessImages({@required dynamic data}) =>
      Backdrops.fromMap(data).backdrops;

  List<Keyword> handlerSuccessKeywords({@required dynamic data}) =>
      Keywords.fromMap(data).keywords;

  Credits handlerSuccessCredits({@required dynamic data}) =>
      Credits.fromMap(data);

  Latest handlerSuccessLatest({@required Map<String, dynamic> data}) =>
      Latest.fromMap(data);

  Future<dynamic> get({
    @required String path,
    @required Function onError,
    @required Function onSuccess,
    String query = '',
    int page = 1,
    int maximum = 50,
  }) async {
    final Uri url = Uri.https(
      _url,
      '3/$path',
      {
        'api_key': _apiKey,
        'language': _language,
        'page': page.toString(),
        'query': query,
        'maximum': maximum.toString(),
      },
    );

    final dynamic response = await http.get(url);

    final dynamic decodedData = await json.decode(response.body);

    if (response.statusCode != 200) return onError(data: decodedData);

    return onSuccess(data: decodedData);
  }

  //  https://developers.themoviedb.org/3/movies/get-latest-movie
  //  Get the most newly created movie. This is a live response and will continuously change.
  Future<List<Movie>> getSearch({@required String query, int page = 1}) async =>
      await get(
        path: 'search/movie',
        page: page,
        query: query,
        onError: handlerError,
        onSuccess: handlerSuccessSearch,
      );

  //  https://developers.themoviedb.org/3/movies/get-latest-movie
  //  Get the most newly created movie. This is a live response and will continuously change.
  Future<Latest> getLatest({int page = 1}) async => await get(
        path: 'movie/latest',
        page: page,
        onError: handlerLatestError,
        onSuccess: handlerSuccessLatest,
      );

  //  https://developers.themoviedb.org/3/movies/get-now-playing
  //  Get a list of movies in theatres. This is a release type query that looks for all movies that have a release type of 2 or 3 within the specified date range.
  //  You can optionally specify a region prameter which will narrow the search to only look for theatrical release dates within the specified country.
  Future<List<Movie>> getNowPlaying({int page = 1}) async => await get(
        path: 'movie/now_playing',
        page: page,
        onError: handlerError,
        onSuccess: handlerSuccessMovies,
      );

  //  https://developers.themoviedb.org/3/movies/get-popular-movies
  //  Get a list of the current popular movies on TMDb. This list updates daily.
  Future<List<Movie>> getPopular({int page = 1}) async => await get(
        path: 'movie/popular',
        page: page,
        onError: handlerError,
        onSuccess: handlerSuccessMovies,
      );

  //  https://developers.themoviedb.org/3/movies/get-top-rated-movies
  //  Get the top rated movies on TMDb.
  Future<List<Movie>> getTopRated({int page = 1}) async => await get(
        path: 'movie/top_rated',
        page: page,
        onError: handlerError,
        onSuccess: handlerSuccessMovies,
      );

  //  https://developers.themoviedb.org/3/movies/get-upcoming
  //  Get a list of upcoming movies in theatres. This is a release type query that looks for all movies that have a release type of 2 or 3 within the specified date range.
  //  You can optionally specify a region prameter which will narrow the search to only look for theatrical release dates within the specified country.
  Future<List<Movie>> getUpcoming({int page = 1}) async => await get(
        path: 'movie/upcoming',
        page: page,
        onError: handlerError,
        onSuccess: handlerSuccessMovies,
      );

  //  https://developers.themoviedb.org/3/movies/get-movie-details
  //  Get the primary information about a movie.
  //  Supports [append_to_response]. Read more about this https://developers.themoviedb.org/3/getting-started/append-to-response.
  Future<List<MovieDetail>> getDetails({
    @required int movieId,
    int page = 1,
  }) async =>
      await get(
        path: '$movieId',
        page: page,
        onError: handlerError,
        onSuccess: handlerSuccessDetails,
      );

  //  https://developers.themoviedb.org/3/movies/get-movie-reviews
  //  Get the user reviews for a movie.
  Future<List<Review>> getReviews({
    @required int movieId,
    int page = 1,
  }) async =>
      await get(
        path: 'movie/$movieId/reviews',
        page: page,
        onError: handlerError,
        onSuccess: handlerSuccessReviews,
      );

  //  https://developers.themoviedb.org/3/movies/get-similar-movies
  //  Get a list of similar movies. This is not the same as the "Recommendation" system you see on the website.
  //  These items are assembled by looking at keywords and genres.
  Future<List<Movie>> getSimilar({@required int movieId, int page = 1}) async =>
      await get(
        path: 'movie/$movieId/similar',
        page: page,
        onError: handlerError,
        onSuccess: handlerSuccessMovies,
      );

  //  https://developers.themoviedb.org/3/movies/get-movie-recommendations
  //  Get a list of recommended movies for a movie.
  Future<List<Movie>> getRecommendations({
    @required int movieId,
    int page = 1,
  }) async =>
      await get(
        path: 'movie/$movieId/recommendations',
        page: page,
        onError: handlerError,
        onSuccess: handlerSuccessMovies,
      );

  //  https://developers.themoviedb.org/3/movies/get-movie-translations
  //  Get a list of translations that have been created for a movie.
  Future<List<Translation>> getTranslations({
    @required int movieId,
    int page = 1,
  }) async =>
      await get(
        path: 'movie/$movieId/translations',
        page: page,
        onError: handlerError,
        onSuccess: handlerSuccessTranslations,
      );

  /*  https://developers.themoviedb.org/3/movies/get-movie-videos
      Get the videos that have been added to a movie.
      Recent Changes
      |----------------|--------------------------------------------------------------------|
      | Date           | Change                                                             |
      |----------------|--------------------------------------------------------------------|
      | March 23, 2019 | Vimeo was added as a video source                                  |
      |----------------|--------------------------------------------------------------------|
      | March 20, 2019 | "Behind the Scenes" and "Bloopers" were added as valid video types |
      |----------------|--------------------------------------------------------------------|
  */
  Future<List<Video>> getVideos({@required int movieId, int page = 1}) async =>
      await get(
        path: 'movie/$movieId/videos',
        page: page,
        onError: handlerError,
        onSuccess: handlerSuccessVideos,
      );

  /*  https://developers.themoviedb.org/3/movies/get-movie-release-dates
      Get the release date along with the certification for a movie.
      Release dates support different types:
        · Premiere
        · Theatrical (limited)
        · Theatrical
        · Digital
        · Physical
        · TV
  */
  Future<List<ReleaseDate>> getReleaseDates({
    @required int movieId,
    int page = 1,
  }) async =>
      await get(
        path: 'movie/$movieId/release_dates',
        page: page,
        onError: handlerError,
        onSuccess: handlerSuccessReleaseDate,
      );

  //  https://developers.themoviedb.org/3/movies/get-movie-keywords
  //  Get the keywords that have been added to a movie.
  Future<List<Keyword>> getKeywords({
    @required int movieId,
    int page = 1,
  }) async =>
      await get(
        path: 'movie/$movieId/keywords',
        page: page,
        onError: handlerError,
        onSuccess: handlerSuccessKeywords,
      );

  /*  https://developers.themoviedb.org/3/movies/get-movie-images
      Get the images that belong to a movie.
      Querying images with a language parameter will filter the results.
        If you want to include a fallback language (especially useful for backdrops) you can use the include_image_language parameter.
      This should be a comma seperated value like so: include_image_language=en,null.
  */
  Future<List<Backdrop>> getImages({
    @required int movieId,
    int page = 1,
  }) async =>
      await get(
        path: 'movie/$movieId/images',
        page: page,
        onError: handlerError,
        onSuccess: handlerSuccessImages,
      );

  //  https://developers.themoviedb.org/3/movies/get-movie-credits
  //  Get the cast and crew for a movie.
  Future<Credits> getCredits({
    @required int movieId,
    int page = 1,
  }) async =>
      await get(
        path: 'movie/$movieId/credits',
        page: page,
        onError: handlerError,
        onSuccess: handlerSuccessCredits,
      );
}
