part of 'watchlist_event_bloc.dart';

abstract class WatchlistEventState extends Equatable {
  const WatchlistEventState();

  @override
  List<Object> get props => [];
}

class WatchlistEventStateEmpty extends WatchlistEventState {}

class WatchlistEventStateLoading extends WatchlistEventState {}

class WatchlistEventStateLoaded extends WatchlistEventState {
  final String message;

  WatchlistEventStateLoaded(this.message);
}

class WatchlistEventStateError extends WatchlistEventState {
  final String message;

  WatchlistEventStateError(this.message);
}
