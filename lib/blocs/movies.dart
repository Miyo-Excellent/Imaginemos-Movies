import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imaginemos_movies/models/backdrop.dart';
import 'package:imaginemos_movies/models/credit.dart';
import 'package:imaginemos_movies/models/keyword.dart';
import 'package:imaginemos_movies/models/latest.dart';
import 'package:imaginemos_movies/models/movie.dart';
import 'package:imaginemos_movies/models/release_date.dart';
import 'package:imaginemos_movies/models/review.dart';
import 'package:imaginemos_movies/models/translation.dart';
import 'package:imaginemos_movies/models/video.dart';
import 'package:imaginemos_movies/providers/movies.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final MoviesProvider _moviesProvider = MoviesProvider();

  final BehaviorSubject<bool> _isLoadingController = BehaviorSubject<bool>();

  final BehaviorSubject<bool> _isInitController = BehaviorSubject<bool>();

  final BehaviorSubject<String> _querySearchController =
      BehaviorSubject<String>();

  final BehaviorSubject<List<Movie>> _searchController =
      BehaviorSubject<List<Movie>>();

  final BehaviorSubject<int> _searchPageController = BehaviorSubject<int>();

  final BehaviorSubject<bool> _isSearchController = BehaviorSubject<bool>();

  final BehaviorSubject<List<Movie>> _nowPlayingController =
      BehaviorSubject<List<Movie>>();

  final BehaviorSubject<int> _nowPlayingPageController = BehaviorSubject<int>();

  final BehaviorSubject<List<Movie>> _upcomingController =
      BehaviorSubject<List<Movie>>();

  final BehaviorSubject<int> _upcomingPageController = BehaviorSubject<int>();

  final BehaviorSubject<List<Movie>> _popularController =
      BehaviorSubject<List<Movie>>();

  final BehaviorSubject<int> _popularPageController = BehaviorSubject<int>();

  final BehaviorSubject<List<Movie>> _topRatedController =
      BehaviorSubject<List<Movie>>();

  final BehaviorSubject<int> _topRatedPageController = BehaviorSubject<int>();

  final BehaviorSubject<Latest> _latestController = BehaviorSubject<Latest>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  Stream<bool> get isInitStream => _isInitController.stream;

  Stream<List<Movie>> get nowPlayingStream => _nowPlayingController.stream;

  Stream<int> get nowPlayingPageStream => _nowPlayingPageController.stream;

  Stream<List<Movie>> get searchStream => _searchController.stream;

  Stream<String> get querySearchStream => _querySearchController.stream;

  Stream<int> get searchPageStream => _searchPageController.stream;

  Stream<bool> get isSearchStream => _isSearchController.stream;

  Stream<List<Movie>> get upcomingStream => _upcomingController.stream;

  Stream<int> get upcomingPageStream => _upcomingPageController.stream;

  Stream<List<Movie>> get popularStream => _popularController.stream;

  Stream<int> get popularPageStream => _popularPageController.stream;

  Stream<List<Movie>> get topRatedStream => _topRatedController.stream;

  Stream<int> get topRatedPageStream => _topRatedPageController.stream;

  Stream<Latest> get latestStream => _latestController.stream;

  bool get isLoading => _isLoadingController.value;

  bool get isInit => _isInitController.value;

  List<Movie> get nowPlaying => _nowPlayingController.value;

  int get nowPlayingPage => _nowPlayingPageController.value;

  List<Movie> get search => _searchController.value;

  String get querySearch => _querySearchController.value;

  int get searchPage => _searchPageController.value;

  bool get isSearch => _isSearchController.value;

  List<Movie> get upcoming => _upcomingController.value;

  int get upcomingPage => _upcomingPageController.value;

  Latest get latest => _latestController.value;

  List<Movie> get popular => _popularController.value;

  int get popularPage => _popularPageController.value;

  List<Movie> get topRated => _topRatedController.value;

  int get topRatedPage => _topRatedPageController.value;

  Function(bool) get changeIsLoading => _isLoadingController.sink.add;

  Function(bool) get changeIsInit => _isInitController.sink.add;

  Function(List<Movie>) get changeNowPlaying => _nowPlayingController.sink.add;

  Function(int) get changeNowPlayingPage => _nowPlayingPageController.sink.add;

  Function(List<Movie>) get changeSearch => _searchController.sink.add;

  Function(String) get changeQuerySearch => _querySearchController.sink.add;

  Function(int) get changeSearchPage => _searchPageController.sink.add;

  Function(bool) get changeIsSearch => _isSearchController.sink.add;

  Function(List<Movie>) get changeUpcoming => _upcomingController.sink.add;

  Function(int) get changeUpcomingPage => _upcomingPageController.sink.add;

  Function(List<Movie>) get changePopular => _popularController.sink.add;

  Function(int) get changePopularPage => _popularPageController.sink.add;

  Function(List<Movie>) get changeTopRated => _topRatedController.sink.add;

  Function(int) get changeTopRatedPage => _topRatedPageController.sink.add;

  Function(Latest) get changeLatest => _latestController.sink.add;

  dispose() {
    _isLoadingController?.close();
    _isInitController?.close();
    _nowPlayingController?.close();
    _nowPlayingPageController?.close();
    _latestController?.close();
    _upcomingController?.close();
    _upcomingPageController?.close();
    _popularController?.close();
    _popularPageController?.close();
    _topRatedController?.close();
    _topRatedPageController?.close();
    _querySearchController?.close();
    _searchController?.close();
    _searchPageController?.close();
    _isSearchController?.close();
  }

  Future<void> getSearch({@required String query}) async {
    changeQuerySearch(query);

    changeIsSearch(true);

    final List<Movie> newSearch =
        await _moviesProvider.getSearch(query: querySearch ?? '');

    changeSearch(newSearch);
    changeIsSearch(false);
  }

  Future<void> getNextSearch() async {
    if (!isSearch) {
      changeIsSearch(true);
      changeSearchPage(searchPage + 1);

      final List<Movie> newSearch = await _moviesProvider.getSearch(
        page: searchPage ?? 1,
        query: querySearch ?? '',
      );

      final List<Movie> _search = search;

      _search.addAll(newSearch);

      changeSearch(_search);
      changeIsSearch(false);
    }
  }

  Future<void> getLatest({int page = 1}) async {
    final Latest _latest = await _moviesProvider.getLatest(page: page);
    changeLatest(_latest);
  }

  Future<void> getUpcoming() async {
    final List<Movie> newUpcoming =
        await _moviesProvider.getUpcoming(page: upcomingPage ?? 1);
    final List<Movie> movies = upcoming;

    movies.addAll(newUpcoming);

    changeUpcoming(movies);
    changeUpcomingPage(upcomingPage + 1);
  }

  Future<void> getTopRated() async {
    final List<Movie> newTopRated =
        await _moviesProvider.getTopRated(page: topRatedPage ?? 1);
    final List<Movie> movies = topRated;

    movies.addAll(newTopRated);

    changeTopRated(movies);
    changeTopRatedPage(topRatedPage + 1);
  }

  Future<void> getPopular() async {
    final List<Movie> newPopular =
        await _moviesProvider.getPopular(page: popularPage ?? 1);
    final List<Movie> movies = upcoming;

    movies.addAll(newPopular);

    changePopular(movies);
    changePopularPage(popularPage + 1);
  }

  Future<void> getNowPlaying() async {
    final List<Movie> nextNowPlaying =
        await _moviesProvider.getNowPlaying(page: nowPlayingPage ?? 1);
    final List<Movie> movies = nowPlaying;

    movies.addAll(nextNowPlaying);

    changeNowPlaying(movies);
    changeNowPlayingPage(nowPlayingPage + 1);
  }

  Future<List<Review>> getReviews({@required int movieId, int page = 1}) async {
    final List<Review> reviews =
        await _moviesProvider.getReviews(movieId: movieId);

    return reviews;
  }

  Future<List<Movie>> getSimilar({@required int movieId, int page = 1}) async {
    final List<Movie> similar =
        await _moviesProvider.getSimilar(movieId: movieId);

    return similar;
  }

  Future<List<Movie>> getRecommendations({
    @required int movieId,
    int page = 1,
  }) async {
    final List<Movie> recommendations =
        await _moviesProvider.getRecommendations(movieId: movieId);

    return recommendations;
  }

  Future<List<Translation>> getTranslations({
    @required int movieId,
    int page = 1,
  }) async {
    final List<Translation> translations =
        await _moviesProvider.getTranslations(movieId: movieId);

    return translations;
  }

  Future<List<Video>> getVideos({
    @required int movieId,
    int page = 1,
  }) async {
    final List<Video> videos =
        await _moviesProvider.getVideos(movieId: movieId);

    return videos;
  }

  Future<List<Backdrop>> getImages({
    @required int movieId,
    int page = 1,
  }) async {
    final List<Backdrop> images =
        await _moviesProvider.getImages(movieId: movieId);

    return images;
  }

  Future<List<ReleaseDate>> getReleaseDates({
    @required int movieId,
    int page = 1,
  }) async {
    final List<ReleaseDate> releaseDates =
        await _moviesProvider.getReleaseDates(movieId: movieId);

    return releaseDates;
  }

  Future<List<Keyword>> getKeywords({
    @required int movieId,
    int page = 1,
  }) async {
    final List<Keyword> keywords =
        await _moviesProvider.getKeywords(movieId: movieId);

    return keywords;
  }

  Future<Credits> getCredits({
    @required int movieId,
    int page = 1,
  }) async {
    final Credits credits = await _moviesProvider.getCredits(movieId: movieId);

    return credits;
  }

  Future<void> init() async {
    try {
      changeIsInit(false);
      changeIsLoading(true);
      changeQuerySearch('');
      changeIsSearch(false);
      changeSearch([]);
      changeSearchPage(1);
      changeNowPlaying([]);
      changeUpcoming([]);
      changePopular([]);
      changeTopRated([]);
      changeNowPlayingPage(1);
      changeUpcomingPage(1);
      changeTopRatedPage(1);
      changePopularPage(1);

      await getLatest();
      await getTopRated();
      await getPopular();
      await getNowPlaying();
      await getUpcoming();

      changeIsInit(true);
      changeIsLoading(false);
    } catch (error) {
      print(error);
      await init();
    }
  }
}
