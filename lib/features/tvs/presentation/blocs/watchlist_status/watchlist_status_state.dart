part of 'watchlist_status_bloc.dart';

abstract class WatchlistStatusState extends Equatable {
  const WatchlistStatusState();

  @override
  List<Object> get props => [];
}

class WatchlistStatusInitial extends WatchlistStatusState {}

class WatchlistStatusTrue extends WatchlistStatusState {}

class WatchlistStatusFalse extends WatchlistStatusState {}
