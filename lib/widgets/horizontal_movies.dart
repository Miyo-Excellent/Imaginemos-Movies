import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imaginemos_movies/models/movie.dart';
import 'package:imaginemos_movies/pages/movie.dart' as moviePage;
import 'package:imaginemos_movies/widgets/movie.dart';

class HorizontalMovies extends StatefulWidget {
  final List<Movie> movies;
  final Function onNextPage;
  final double posterWidth = 150.0;
  final double posterHeight = 230.0;
  final double titleHeight = 20.0;
  final double ratingHeight = 40.0;
  final double padding = 10.0;
  final double breakpointToReload = 300.0;

  HorizontalMovies({
    @required this.movies,
    @required this.onNextPage,
  });

  @override
  _HorizontalMoviesState createState() => _HorizontalMoviesState();
}

class _HorizontalMoviesState extends State<HorizontalMovies> {
  final ScrollController _controller = ScrollController();

  bool _isLoading = false;

  void _onTap({
    @required BuildContext ctx,
    @required Movie data,
  }) {
    Navigator.pushNamed(
      context,
      moviePage.Movie.routeName,
      arguments: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size viewport = MediaQuery.of(context).size;
    final double height =
        widget.titleHeight + widget.posterHeight + widget.ratingHeight;

    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - widget.breakpointToReload) {
        if (!_isLoading) {
          Future.delayed(Duration(seconds: 0)).then((value) async {
            setState(() => _isLoading = true);

            await widget.onNextPage();

            setState(() => _isLoading = false);
          });
        }
      }
    });

    return Container(
      width: viewport.width,
      height: height - widget.padding,
      child: ListView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: widget.movies.length,
        itemBuilder: (BuildContext itemCtx, int index) => Cover(
          data: widget.movies[index],
          onTap: () => _onTap(ctx: itemCtx, data: widget.movies[index]),
          posterWidth: widget.posterWidth,
          posterHeight: widget.posterHeight,
          titleHeight: widget.titleHeight,
          ratingHeight: widget.ratingHeight,
          padding: widget.padding,
        ),
      ),
    );
  }
}
