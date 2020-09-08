import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imaginemos_movies/blocs/provider.dart';
import 'package:imaginemos_movies/models/credit.dart';
import 'package:imaginemos_movies/models/movie.dart' as models;
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Movie extends StatefulWidget {
  static final String routeName = 'movie';
  final double ratingHeight = 40.0;

  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  final ScrollController _controller = ScrollController();
  final ScrollController _castController = ScrollController();

  bool _isReady = false;
  double _popularity = 0.0;

  @override
  Widget build(BuildContext context) {
    final MoviesBloc moviesBloc = ProviderBloc.movies(context);
    final Size viewport = MediaQuery.of(context).size;
    final models.Movie data = ModalRoute.of(context).settings.arguments;

    if (!_isReady) {
      setState(() {
        _popularity = data.voteAverage / 2;
        _isReady = true;
      });
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 53, 70, 1.0),
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          _appBar(movie: data),
          _content(
            movie: data,
            creditsFuture: moviesBloc.getCredits(movieId: data.id),
            viewport: viewport,
          ),
        ],
      ),
    );
  }

  Widget _appBar({@required models.Movie movie}) => SliverAppBar(
        backgroundColor: Colors.transparent,
        elevation: 2.0,
        expandedHeight: 400.0,
        floating: true,
//        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
//          title: Text(movie.title),
          background: FadeInImage(
            placeholder: AssetImage('assets/animations/loader_hand.webp'),
            image: NetworkImage(movie.getBackdrop()),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
      );

  Widget _content({
    @required models.Movie movie,
    @required Future<Credits> creditsFuture,
    @required Size viewport,
  }) =>
      SliverList(
        delegate: SliverChildListDelegate([
          Container(
            constraints: BoxConstraints(minHeight: viewport.height),
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                _title(text: movie.title),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _watchNow(onTap: () {}),
                    _rating(
                      count: _popularity,
                      height: widget.ratingHeight,
                      size: 25.0,
                      onRated: (double newRated) => setState(
                        () => _popularity = newRated,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                _overview(text: movie.overview),
                SizedBox(height: 20.0),
                FutureBuilder(
                  future: creditsFuture,
                  builder: (
                    BuildContext futureCtx,
                    AsyncSnapshot<Credits> snapshot,
                  ) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          _castList(cast: snapshot.data.cast),
                          SizedBox(height: 20.0),
                          _crewList(crew: snapshot.data.crew),
                        ],
                      );
                    }

                    return LinearProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ]),
      );

  Widget _title({@required String text}) => Row(
        children: [
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 24.0,
              ),
            ),
          ),
        ],
      );

  Widget _watchNow({@required Function onTap}) => Material(
        borderRadius: BorderRadius.circular(30.0),
        color: Color.fromRGBO(107, 115, 128, 1.0),
        child: InkWell(
          onTap: onTap,
          splashColor: Color.fromRGBO(40, 53, 70, 1.0),
          borderRadius: BorderRadius.circular(30.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Center(
                child: Text(
                  'Watch now'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _overview({@required String text}) => Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
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

  Widget _castList({@required List<Cast> cast, double size = 80.0}) =>
      Container(
        constraints: BoxConstraints(minHeight: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                'Cast',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: size * 1.7,
              child: ListView.builder(
                itemCount: cast.length,
                scrollDirection: Axis.horizontal,
                controller: _castController,
                itemBuilder: (BuildContext itemCtx, int itemIndex) => Container(
                  width: size,
                  margin: EdgeInsets.only(
                    right: itemIndex + 1 == cast.length ? 0.0 : 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(size / 2),
                        child: Container(
                          width: size,
                          height: size,
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(cast[itemIndex].getProfile()),
                            placeholder: AssetImage(
                              'assets/animations/loader_hand.webp',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        child: Text(
                          cast[itemIndex].name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        child: Text(
                          cast[itemIndex].character,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _crewList({@required List<Crew> crew, double size = 80.0}) =>
      Container(
        constraints: BoxConstraints(minHeight: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                'Crew',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: size * 1.7,
              child: ListView.builder(
                itemCount: crew.length,
                scrollDirection: Axis.horizontal,
                controller: _castController,
                itemBuilder: (BuildContext itemCtx, int itemIndex) => Container(
                  width: size,
                  margin: EdgeInsets.only(
                    right: itemIndex + 1 == crew.length ? 0.0 : 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(size / 2),
                        child: Container(
                          width: size,
                          height: size,
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(crew[itemIndex].getProfile()),
                            placeholder: AssetImage(
                              'assets/animations/loader_hand.webp',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        child: Text(
                          crew[itemIndex].name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        child: Text(
                          crew[itemIndex].job,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
