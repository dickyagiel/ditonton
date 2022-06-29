part of 'search_tv_bloc.dart';

abstract class SearchTvEvent extends Equatable {
  const SearchTvEvent();

  @override
  List<Object> get props => [];
}

class SearchTv extends SearchTvEvent {
  final String query;
  SearchTv(this.query);
}
