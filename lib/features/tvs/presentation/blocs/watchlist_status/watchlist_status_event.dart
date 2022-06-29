part of 'watchlist_status_bloc.dart';

abstract class WatchlistStatusEvent extends Equatable {
  const WatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class WatchlistStatus extends WatchlistStatusEvent {
  final int id;

  WatchlistStatus(this.id);
}
