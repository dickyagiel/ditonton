part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class GetSearchMovieEvent extends SearchMovieEvent {
  final String query;

  GetSearchMovieEvent(this.query);
}
