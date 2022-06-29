import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/features/movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/recommendations_movie/recommendations_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/search_tv/search_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/watchlist_movie_event/watchlist_movie_event_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/watchlist_movie_status/watchlist_movie_status_bloc.dart';
import 'package:ditonton/features/movies/presentation/pages/about_page.dart';
import 'package:ditonton/features/movies/presentation/pages/home_movie_page.dart';
import 'package:ditonton/features/movies/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/features/movies/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/features/movies/presentation/pages/search_page.dart';
import 'package:ditonton/features/movies/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/features/movies/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/features/tvs/presentation/blocs/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/popular_tv/popular_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/search_tv/search_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/top_rated_tv/top_rate_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/tv_recommendations/recommendations_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/watchlist_event/watchlist_event_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/watchlist_status/watchlist_status_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/pages/home_tv_page.dart';
import 'package:ditonton/features/tvs/presentation/pages/popular_tv_page.dart';
import 'package:ditonton/features/tvs/presentation/pages/search_tv_page.dart';
import 'package:ditonton/features/tvs/presentation/pages/top_rated_tv_page.dart';
import 'package:ditonton/features/tvs/presentation/pages/tv_detail_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<NowPlayingTvBloc>(
          create: (_) => di.locator<NowPlayingTvBloc>(),
        ),
        BlocProvider<PopularTvBloc>(
          create: (_) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider<TopRateTvBloc>(
          create: (_) => di.locator<TopRateTvBloc>(),
        ),
        BlocProvider<SearchTvBloc>(
          create: (_) => di.locator<SearchTvBloc>(),
        ),
        BlocProvider<WatchlistTvBloc>(
          create: (_) => di.locator<WatchlistTvBloc>(),
        ),
        BlocProvider<TvDetailBloc>(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider<RecommendationsTvBloc>(
          create: (_) => di.locator<RecommendationsTvBloc>(),
        ),
        BlocProvider<WatchlistEventBloc>(
          create: (_) => di.locator<WatchlistEventBloc>(),
        ),
        BlocProvider<WatchlistStatusBloc>(
          create: (_) => di.locator<WatchlistStatusBloc>(),
        ),
        BlocProvider<MovieDetailBloc>(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider<NowPlayingMovieBloc>(
          create: (_) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider<PopularMovieBloc>(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider<RecommendationsMovieBloc>(
          create: (_) => di.locator<RecommendationsMovieBloc>(),
        ),
        BlocProvider<SearchMovieBloc>(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider<TopRatedMovieBloc>(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider<WatchlistMovieBloc>(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider<WatchlistMovieEventBloc>(
          create: (_) => di.locator<WatchlistMovieEventBloc>(),
        ),
        BlocProvider<WatchlistMovieStatusBloc>(
          create: (_) => di.locator<WatchlistMovieStatusBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case HomeTVPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTVPage());
            case PopularTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTVPage());
            case TopRatedTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTVPage());
            case TVDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTVPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
