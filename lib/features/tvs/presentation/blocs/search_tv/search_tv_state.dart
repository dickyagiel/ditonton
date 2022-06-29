part of 'search_tv_bloc.dart';

abstract class SearchTvState extends Equatable {
  const SearchTvState();

  @override
  List<Object> get props => [];
}

class SearchTvStateEmpty extends SearchTvState {}

class SearchTvStateLoading extends SearchTvState {}

class SearchTvStateLoaded extends SearchTvState {
  final List<TV> result;

  SearchTvStateLoaded(this.result);
}

class SearchTvStateError extends SearchTvState {
  final String message;

  SearchTvStateError(this.message);
}
