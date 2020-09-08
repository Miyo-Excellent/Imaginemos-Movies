import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imaginemos_movies/blocs/provider.dart';
import 'package:imaginemos_movies/pages/home.dart';
import 'package:imaginemos_movies/pages/movie.dart';
import 'package:imaginemos_movies/pages/splash.dart';

void main() async => runApp(Root());

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ProviderBloc(child: App());
}

class App extends StatefulWidget {
  static final String name = 'Movies App';

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final MoviesBloc moviesBloc = ProviderBloc.movies(context);

    moviesBloc.init();

    return MaterialApp(
      title: App.name,
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.routeName,
      routes: {
        Home.routeName: (BuildContext context) => Home(),
        Movie.routeName: (BuildContext context) => Movie(),
        Splash.routeName: (BuildContext context) => Splash(),
      },
    );
  }
}
