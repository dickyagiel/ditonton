import 'package:ditonton/common/http_ssl_pining.dart';
import 'package:ditonton/features/movies/data/datasources/db/database_helper.dart';
import 'package:ditonton/features/movies/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/features/movies/domain/repositories/movie_repository.dart';
import 'package:ditonton/features/movies/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/features/movies/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/features/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/features/movies/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/features/movies/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/features/movies/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/features/movies/domain/usecases/save_watchlist.dart';
import 'package:ditonton/features/movies/domain/usecases/search_movies.dart';
import 'package:ditonton/features/movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/recommendations_movie/recommendations_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/search_tv/search_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/watchlist_movie_event/watchlist_movie_event_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/watchlist_movie_status/watchlist_movie_status_bloc.dart';
import 'package:ditonton/features/tvs/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/features/tvs/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/features/tvs/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/features/tvs/domain/repositories/tv_repository.dart';
import 'package:ditonton/features/tvs/domain/usecases/get_now_playing_tv.dart';
import 'package:ditonton/features/tvs/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/features/tvs/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/features/tvs/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/features/tvs/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/features/tvs/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/features/tvs/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/features/tvs/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/features/tvs/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/features/tvs/domain/usecases/search_tv.dart';
import 'package:ditonton/features/tvs/presentation/blocs/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/popular_tv/popular_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/search_tv/search_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/top_rated_tv/top_rate_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/tv_recommendations/recommendations_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/watchlist_event/watchlist_event_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/watchlist_status/watchlist_status_bloc.dart';
import 'package:ditonton/features/tvs/presentation/blocs/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieDetailBloc(
      usecase: locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingMovieBloc(
      usecase: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMovieBloc(
      usecase: locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationsMovieBloc(
      usecase: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchMovieBloc(
      usecase: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMovieBloc(
      usecase: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieEventBloc(
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieStatusBloc(
      usecase: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // tv provider
  locator.registerFactory(
    () => RecommendationsTvBloc(
      getTvRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistStatusBloc(
      getWatchlistTVStatus: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistEventBloc(
      removeWatchListTv: locator(),
      saveWatchListTv: locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingTvBloc(
      getNowPlayingTv: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvBloc(
      getPopularTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRateTvBloc(
      getTopRateTv: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvBloc(
      searchTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailBloc(
      getTvDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvBloc(
      getWatchListTv: locator(),
    ),
  );

  // tv use case
  locator.registerLazySingleton(() => GetNowPlayingTV(locator()));
  locator.registerLazySingleton(() => GetPopularTV(locator()));
  locator.registerLazySingleton(() => GetTopRatedTV(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTV(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTV(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTV(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTV(locator()));
  locator.registerLazySingleton(() => GetWatchlistTV(locator()));

  // tv repository
  locator.registerLazySingleton<TVRepository>(
    () => TVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // tv data sources
  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
      () => TVLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
