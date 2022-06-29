import 'package:bloc/bloc.dart';
import 'package:ditonton/features/movies/domain/usecases/get_watchlist_status.dart';
import 'package:equatable/equatable.dart';
part 'watchlist_movie_status_event.dart';
part 'watchlist_movie_status_state.dart';

class WatchlistMovieStatusBloc
    extends Bloc<WatchlistMovieStatusEvent, WatchlistMovieStatusState> {
  final GetWatchListStatus usecase;
  WatchlistMovieStatusBloc({required this.usecase})
      : super(WatchlistMovieStatusInitial()) {
    on<GetWatchlistMovieStatusEvent>((event, emit) async {
      final result = await usecase.execute(event.id);
      if (result) {
        emit(WatchlistMovieStatusTrue());
      } else {
        emit(WatchlistMovieStatusFalse());
      }
    });
  }
}
