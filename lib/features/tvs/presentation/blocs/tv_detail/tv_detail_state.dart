part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailStateEmpty extends TvDetailState {}

class TvDetailStateLoading extends TvDetailState {}

class TvDetailStateLoaded extends TvDetailState {
  final TVDetail result;

  TvDetailStateLoaded(this.result);
}

class TvDetailStateError extends TvDetailState {
  final String message;

  TvDetailStateError(this.message);
}
