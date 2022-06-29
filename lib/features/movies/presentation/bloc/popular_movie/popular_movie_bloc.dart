import 'package:bloc/bloc.dart';
import 'package:ditonton/features/movies/domain/entities/movie.dart';
import 'package:ditonton/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies usecase;
  PopularMovieBloc({required this.usecase}) : super(PopularMovieInitial()) {
    on<PopularMovieEvent>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await usecase.execute();

      result.fold(
        (failure) => emit(PopularMovieError(failure.message)),
        (result) => emit(PopularMovieLoaded(result)),
      );
    });
  }
}
