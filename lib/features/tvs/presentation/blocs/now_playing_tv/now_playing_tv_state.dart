part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTvState extends Equatable {
  const NowPlayingTvState();

  @override
  List<Object> get props => [];
}

class NowPlayingStateEmpty extends NowPlayingTvState {}

class NowPlayingStateLoading extends NowPlayingTvState {}

class NowPlayingStateLoaded extends NowPlayingTvState {
  final List<TV> result;

  NowPlayingStateLoaded(this.result);
}

class NowPlayingStateError extends NowPlayingTvState {
  final String message;

  NowPlayingStateError(this.message);
}
