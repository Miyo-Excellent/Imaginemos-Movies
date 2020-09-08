import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imaginemos_movies/blocs/provider.dart';
import 'package:imaginemos_movies/models/movie.dart';
import 'package:imaginemos_movies/pages/movie.dart' as moviePage;
import 'package:imaginemos_movies/widgets/horizontal_movies_generator.dart';
import 'package:imaginemos_movies/widgets/movie.dart';
import 'package:rxdart/rxdart.dart';

class Home extends StatefulWidget {
  static final String routeName = 'home';
  final double headerHeight = 200.0;
  final double searchBreakpointToReload = 300.0;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _controller = ScrollController();
  final ScrollController _searchController = ScrollController();

  void onChangedSearch(String query, {@required MoviesBloc moviesBloc}) {
    moviesBloc.getSearch(query: query);
  }

  void _onSearchMovieTap({
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
    final MoviesBloc moviesBloc = ProviderBloc.movies(context);
    final Size viewport = MediaQuery.of(context).size;

    _searchController.addListener(() {
      if (_searchController.position.pixels >=
          _searchController.position.maxScrollExtent -
              widget.searchBreakpointToReload) {
        if (moviesBloc.isSearch is bool && !moviesBloc.isSearch) {
          Future.delayed(Duration(seconds: 0)).then((value) async {
            await moviesBloc.getNextSearch();
          });
        }
      }
    });

    return Scaffold(
//      backgroundColor: Color.fromRGBO(40, 53, 70, 1.0),
      backgroundColor: Color.fromRGBO(91, 161, 213, 1.0),
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          _header(moviesBloc: moviesBloc),
          _body(viewport: viewport, moviesBloc: moviesBloc),
        ],
      ),
    );
  }

  Widget _divider() => SizedBox(height: 20.0);

  Widget _header({@required MoviesBloc moviesBloc}) => SliverAppBar(
        backgroundColor: Color.fromRGBO(91, 161, 213, 1.0),
        elevation: 2.0,
        expandedHeight: 240.0,
        floating: true,
//        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
//          title: Text(movie.title),
          background: Container(
            height: widget.headerHeight,
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Hello, what do you want to watch?',
                  textScaleFactor: 2.1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.0),
                Theme(
                  data: ThemeData(
                    primaryColor: Colors.white,
                    primaryColorDark: Colors.white,
                  ),
                  child: TextField(
//                    autofocus: true,
                    onChanged: (String query) =>
                        onChangedSearch(query, moviesBloc: moviesBloc),
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      icon: Icon(
                        Icons.search,
                        size: 40.0,
                      ),
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        borderSide: BorderSide(
                          width: 5.0,
                          style: BorderStyle.solid,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _body({@required Size viewport, @required MoviesBloc moviesBloc}) =>
      SliverList(
        delegate: SliverChildListDelegate(
          [
            StreamBuilder(
              stream: moviesBloc.querySearchStream,
              initialData: '',
              builder: (
                BuildContext streamCtx,
                AsyncSnapshot<String> snapshot,
              ) {
                if (snapshot.data.isEmpty) {
                  return _content(
                    viewport: viewport,
                    moviesBloc: moviesBloc,
                  );
                }

                return _contentSearch(
                  viewport: viewport,
                  moviesBloc: moviesBloc,
                );
              },
            ),
          ],
        ),
      );

  Widget _contentLayout({@required Widget child}) => Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            child: child,
          ),
        ],
      );

  Widget _content({@required Size viewport, @required MoviesBloc moviesBloc}) =>
      _contentLayout(
        child: Container(
          color: Color.fromRGBO(40, 53, 70, 1.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _divider(),
              HorizontalMoviesGenerator(
                viewport: viewport,
                title: "Recommended for you".toUpperCase(),
                stream: moviesBloc.nowPlayingStream,
                onNextPage: moviesBloc.getNowPlaying,
              ),
              _divider(),
              HorizontalMoviesGenerator(
                viewport: viewport,
                title: "Upcoming".toUpperCase(),
                stream: moviesBloc.upcomingStream,
                onNextPage: moviesBloc.getUpcoming,
              ),
              _divider(),
              HorizontalMoviesGenerator(
                viewport: viewport,
                title: "Top Rated".toUpperCase(),
                stream: moviesBloc.topRatedStream,
                onNextPage: moviesBloc.getTopRated,
              ),
              _divider(),
              HorizontalMoviesGenerator(
                viewport: viewport,
                title: "Popular".toUpperCase(),
                stream: moviesBloc.popularStream,
                onNextPage: moviesBloc.getPopular,
              ),
              _divider(),
            ],
          ),
        ),
      );

  Widget _contentSearch({
    @required Size viewport,
    @required MoviesBloc moviesBloc,
  }) =>
      _contentLayout(
        child: StreamBuilder(
          initialData: <String, dynamic>{'search': <Movie>[], 'isSearch': true},
          stream: Rx.combineLatest2(
            moviesBloc.searchStream,
            moviesBloc.isSearchStream,
            (List<Movie> search, bool isSearch) => <String, dynamic>{
              'search': search,
              'isSearch': isSearch,
            },
          ),
          builder: (
            BuildContext streamCtx,
            AsyncSnapshot<Map<String, dynamic>> snapshot,
          ) {
            if (!snapshot.hasData) {
              return Container(child: LinearProgressIndicator());
            }

            final double _height = viewport.height - widget.headerHeight;
            final double _width = viewport.width;
            final int _crossAxisCount = 3;
            final int _mainAxisCount = 2;
            final double _coverHeight = (_height / _mainAxisCount);
            final double _coverPosterWidth = _width / _crossAxisCount;
            final double _coverPosterHeight = _coverHeight - 95.0;
            final double _coverTitleHeight = 30.0;
            final double _coverRatingHeight = 30.0;
            final List<Movie> search = snapshot.data['search'];
            final bool isSearch = snapshot.data['isSearch'];

//            if (isSearch) return Container(child: LinearProgressIndicator());

            final List<Widget> children = search
                .map(
                  (Movie movie) => Cover(
                    data: movie,
                    posterWidth: _coverPosterWidth,
                    posterHeight: _coverPosterHeight,
                    titleHeight: _coverTitleHeight,
                    ratingHeight: _coverRatingHeight,
                    padding: 0.0,
                    onTap: () => _onSearchMovieTap(ctx: streamCtx, data: movie),
                  ),
                )
                .toList();

            return Center(
              child: Container(
                color: Color.fromRGBO(40, 53, 70, 1.0),
                padding: EdgeInsets.only(top: 20.0, right: 20.0),
                height: viewport.height,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Container(
                        width: _width * 0.8,
                        height: 5.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: _width,
                      height: viewport.height - 45.0,
                      child: GridView.count(
                        controller: _searchController,
                        crossAxisCount: _crossAxisCount,
                        childAspectRatio: _coverPosterWidth / _coverHeight,
                        children: children,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
}
