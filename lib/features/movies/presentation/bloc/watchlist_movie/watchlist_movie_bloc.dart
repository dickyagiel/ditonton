import 'package:bloc/bloc.dart';
import 'package:ditonton/features/movies/domain/entities/movie.dart';
import 'package:ditonton/features/movies/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;
  WatchlistMovieBloc({required this.getWatchlistMovies})
      : super(WatchlistMovieInitial()) {
    on<WatchlistMovieEvent>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await getWatchlistMovies.execute();

      result.fold(
        (failure) => emit(WatchlistMovieError(failure.message)),
        (result) => emit(WatchlistMovieLoaded(result)),
      );
    });
  }
}
