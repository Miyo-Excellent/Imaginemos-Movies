import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imaginemos_movies/models/movie.dart';
import 'package:imaginemos_movies/widgets/horizontal_list_header.dart';
import 'package:imaginemos_movies/widgets/horizontal_movies.dart';

class HorizontalMoviesGenerator extends StatelessWidget {
  final Size viewport;
  final Stream<List<Movie>> stream;
  final String title;
  final Function onNextPage;

  HorizontalMoviesGenerator({
    @required this.viewport,
    @required this.stream,
    @required this.title,
    @required this.onNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext streamCtx, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0, width: viewport.width),
              HorizontalListHeader(title: title),
              SizedBox(height: 10.0, width: viewport.width),
              HorizontalMovies(
                movies: snapshot.data,
                onNextPage: onNextPage,
              ),
            ],
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
