part of 'watchlist_movie_event_bloc.dart';

abstract class WatchlistMovieEventEvent extends Equatable {
  const WatchlistMovieEventEvent();

  @override
  List<Object> get props => [];
}

class RemoveWatchlistMovie extends WatchlistMovieEventEvent {
  final MovieDetail movie;

  RemoveWatchlistMovie(this.movie);
}

class AddWatchlistMovie extends WatchlistMovieEventEvent {
  final MovieDetail movie;

  AddWatchlistMovie(this.movie);
}
