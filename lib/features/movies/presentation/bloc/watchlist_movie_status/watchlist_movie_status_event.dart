part of 'watchlist_movie_status_bloc.dart';

abstract class WatchlistMovieStatusEvent extends Equatable {
  const WatchlistMovieStatusEvent();

  @override
  List<Object> get props => [];
}

class GetWatchlistMovieStatusEvent extends WatchlistMovieStatusEvent {
  final int id;

  GetWatchlistMovieStatusEvent(this.id);
}
