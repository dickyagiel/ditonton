part of 'watchlist_movie_event_bloc.dart';

abstract class WatchlistMovieEventState extends Equatable {
  const WatchlistMovieEventState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieEventInitial extends WatchlistMovieEventState {}

class WatchlistMovieEventLoading extends WatchlistMovieEventState {}

class WatchlistMovieEventLoaded extends WatchlistMovieEventState {
  final String message;

  WatchlistMovieEventLoaded(this.message);
}

class WatchlistMovieEventError extends WatchlistMovieEventState {
  final String message;

  WatchlistMovieEventError(this.message);
}
