part of 'top_rate_tv_bloc.dart';

abstract class TopRateTvState extends Equatable {
  const TopRateTvState();

  @override
  List<Object> get props => [];
}

class TopRateTvStateEmpty extends TopRateTvState {}

class TopRateTvStateLoading extends TopRateTvState {}

class TopRateTvStateLoaded extends TopRateTvState {
  final List<TV> result;

  TopRateTvStateLoaded(this.result);
}

class TopRateTvStateError extends TopRateTvState {
  final String message;

  TopRateTvStateError(this.message);
}
