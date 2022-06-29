part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class WatchlistTvStateEmpty extends WatchlistTvState {}

class WatchlistTvStateLoading extends WatchlistTvState {}

class WatchlistTvStateLoaded extends WatchlistTvState {
  final List<TV> result;

  WatchlistTvStateLoaded(this.result);
}

class WatchlistTvStateError extends WatchlistTvState {
  final String message;

  WatchlistTvStateError(this.message);
}
