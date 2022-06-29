import 'package:ditonton/features/movies/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ditonton/features/movies/domain/usecases/search_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies usecase;
  SearchMovieBloc({required this.usecase}) : super(SearchMovieInitial()) {
    on<GetSearchMovieEvent>((event, emit) async {
      emit(SearchMovieLoading());
      final result = await usecase.execute(event.query);

      result.fold(
        (failure) => emit(SearchMovieError(failure.message)),
        (result) => emit(SearchMovieLoaded(result)),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
