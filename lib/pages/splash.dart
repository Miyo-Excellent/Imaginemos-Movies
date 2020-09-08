import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imaginemos_movies/blocs/provider.dart';
import 'package:imaginemos_movies/pages/home.dart';

class Splash extends StatefulWidget {
  static final String routeName = "splash";

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _isReady = false;

  void goHome(BuildContext ctx) {
    if (!_isReady) {
      Navigator.pushNamedAndRemoveUntil(
        ctx,
        Home.routeName,
        (Route<dynamic> route) => false,
      );

      setState(() => _isReady = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoviesBloc moviesBloc = ProviderBloc.movies(context);

    //  Hidden Status Bar & Bottom menu
    SystemChrome.setEnabledSystemUIOverlays([]);

    moviesBloc.isInitStream.listen((bool isInit) {
      if (isInit) goHome(context);
    });

    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 1.0),
      body: _background(),
    );
  }

  Widget _loadingText() => Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: Center(
          child: Text(
            'Cargando...',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
      );

  Widget _loading() => Container(
        child: Center(
          child: LinearProgressIndicator(),
        ),
      );

  Widget _animation() => Expanded(
        child: Image(
          image: AssetImage("assets/animations/loader.gif"),
        ),
      );

  Widget _background() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _loading(),
            _animation(),
            _loadingText(),
            _loading(),
          ],
        ),
      );
}
