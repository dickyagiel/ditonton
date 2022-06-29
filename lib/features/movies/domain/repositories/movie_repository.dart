import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movies/domain/entities/movie.dart';
import 'package:ditonton/features/movies/domain/entities/movie_detail.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Movie>>> getWatchlistMovies();
}

// abstract class TVRepository {
//   Future<Either<Failure, List<TV>>> getNowPlayingTV();
//   Future<Either<Failure, List<TV>>> getPopularTV();
//   Future<Either<Failure, List<TV>>> getTopRatedTV();
//   Future<Either<Failure, TVDetail>> getTVDetail(int id);
//   Future<Either<Failure, List<TV>>> getTVRecommendations(int id);
//   Future<Either<Failure, List<TV>>> searchTV(String query);
//   Future<Either<Failure, String>> saveWatchlist(TVDetail tv);
//   Future<Either<Failure, String>> removeWatchlist(TVDetail tv);
//   Future<bool> isAddedToWatchlist(int id);
//   Future<Either<Failure, List<TV>>> getWatchlistTV();
// }
