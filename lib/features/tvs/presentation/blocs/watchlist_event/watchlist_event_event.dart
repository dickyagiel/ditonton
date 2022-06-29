part of 'watchlist_event_bloc.dart';

abstract class WatchlistEventEvent extends Equatable {
  const WatchlistEventEvent();

  @override
  List<Object> get props => [];
}

class AddtoWatchList extends WatchlistEventEvent {
  final TVDetail tv;

  AddtoWatchList(this.tv);
}

class RemoveWatchList extends WatchlistEventEvent {
  final TVDetail tv;

  RemoveWatchList(this.tv);
}
