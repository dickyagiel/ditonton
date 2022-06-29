part of 'top_rated_movie_bloc.dart';

abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object> get props => [];
}

class TopRatedMovieInitial extends TopRatedMovieState {}

class TopRatedMovieLoading extends TopRatedMovieState {}

class TopRatedMovieLoaded extends TopRatedMovieState {
  final List<Movie> result;

  TopRatedMovieLoaded(this.result);
}

class TopRatedMovieError extends TopRatedMovieState {
  final String message;

  TopRatedMovieError(this.message);
}
