import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:imaginemos_movies/blocs/movies.dart';
export 'package:imaginemos_movies/blocs/movies.dart';

class ProviderBloc extends InheritedWidget {
  static getProvider(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ProviderBloc) as ProviderBloc);

  static MoviesBloc movies(BuildContext context) =>
      getProvider(context).moviesBloc;

  final MoviesBloc moviesBloc = MoviesBloc();

  ProviderBloc({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
