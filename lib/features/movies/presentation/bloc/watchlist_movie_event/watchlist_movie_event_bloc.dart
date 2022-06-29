import 'package:bloc/bloc.dart';
import 'package:ditonton/features/movies/domain/entities/movie_detail.dart';
import 'package:ditonton/features/movies/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/features/movies/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
part 'watchlist_movie_event_event.dart';
part 'watchlist_movie_event_state.dart';

class WatchlistMovieEventBloc
    extends Bloc<WatchlistMovieEventEvent, WatchlistMovieEventState> {
  final RemoveWatchlist removeWatchlist;
  final SaveWatchlist saveWatchlist;
  WatchlistMovieEventBloc(
      {required this.saveWatchlist, required this.removeWatchlist})
      : super(WatchlistMovieEventInitial()) {
    on<RemoveWatchlistMovie>((event, emit) async {
      emit(WatchlistMovieEventLoading());
      final result = await removeWatchlist.execute(event.movie);
      result.fold(
        (failure) => emit(WatchlistMovieEventError(failure.message)),
        (result) => emit(WatchlistMovieEventLoaded(result)),
      );
    });
    on<AddWatchlistMovie>((event, emit) async {
      emit(WatchlistMovieEventLoading());
      final result = await saveWatchlist.execute(event.movie);
      result.fold(
        (failure) => emit(WatchlistMovieEventError(failure.message)),
        (result) => emit(WatchlistMovieEventLoaded(result)),
      );
    });
  }
}
