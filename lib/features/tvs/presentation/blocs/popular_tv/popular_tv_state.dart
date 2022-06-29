part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

class PopularTvStateEmpty extends PopularTvState {}

class PopularTvStateLoading extends PopularTvState {}

class PopularTvStateLoaded extends PopularTvState {
  final List<TV> result;

  PopularTvStateLoaded(this.result);
}

class PopularTvStateError extends PopularTvState {
  final String message;

  PopularTvStateError(this.message);
}
