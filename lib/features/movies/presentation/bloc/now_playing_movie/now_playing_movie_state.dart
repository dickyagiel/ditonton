part of 'now_playing_movie_bloc.dart';

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object> get props => [];
}

class NowPlayingMovieInitial extends NowPlayingMovieState {}

class NowPlayingMovieLoading extends NowPlayingMovieState {}

class NowPlayingMovieLoaded extends NowPlayingMovieState {
  final List<Movie> result;

  NowPlayingMovieLoaded(this.result);
}

class NowPlayingMovieError extends NowPlayingMovieState {
  final String message;

  NowPlayingMovieError(this.message);
}
