import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imaginemos_movies/models/movie.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Cover extends StatefulWidget {
  final Movie data;
  final double posterWidth;
  final double posterHeight;
  final double titleHeight;
  final double ratingHeight;
  final double padding;
  final Function onTap;

  Cover({
    @required this.data,
    @required this.posterWidth,
    @required this.posterHeight,
    @required this.titleHeight,
    @required this.ratingHeight,
    @required this.padding,
    @required this.onTap,
  });

  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Cover> {
  double _popularity = 0.0;

  @override
  void initState() {
    setState(() => _popularity = widget.data.voteAverage / 2);
  }

  @override
  Widget build(BuildContext context) {
    final double height =
        widget.titleHeight + widget.posterHeight + widget.ratingHeight;

    return _tapper(
      onTap: widget.onTap,
      child: Container(
        width: widget.posterWidth,
        height: height - widget.padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _poster(
              path: widget.data.getPoster(),
              placeholder: 'assets/animations/loader_hand.webp',
              height: widget.posterHeight,
            ),
            SizedBox(height: 5.0),
            _title(
              text: widget.data.title,
              height: widget.titleHeight,
              size: 14.0,
            ),
            SizedBox(height: 5.0),
            _rating(
              count: _popularity,
              height: widget.ratingHeight,
              size: 20.0,
              onRated: (double newRated) => setState(() {
                _popularity = newRated;
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tapper({@required Widget child, @required Function onTap}) => Container(
        margin: EdgeInsets.only(left: 20.0),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
          child: InkWell(
            child: child,
            onTap: onTap ?? () {},
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );

  Widget _poster({
    @required String path,
    @required String placeholder,
    @required double height,
  }) =>
      Container(
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: FadeInImage(
            height: height,
            fit: BoxFit.cover,
            image: NetworkImage(path),
            placeholder: AssetImage(placeholder),
          ),
        ),
      );

  Widget _title({
    @required String text,
    @required double height,
    double size = 16.0,
  }) =>
      Container(
        height: height,
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _rating({
    @required double count,
    @required double height,
    @required Function(double) onRated,
    double size = 18.0,
  }) =>
      Container(
//        height: height,
        child: Row(
          children: [
            SmoothStarRating(
              rating: count,
              isReadOnly: false,
              size: size,
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              defaultIconData: Icons.star_border,
              color: Colors.amber,
              borderColor: Colors.white,
              starCount: 5,
              allowHalfRating: true,
              spacing: 2.0,
              onRated: onRated ?? (double value) {},
            )
          ],
        ),
      );
}
