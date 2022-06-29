import 'package:bloc/bloc.dart';
import 'package:ditonton/features/movies/domain/entities/movie.dart';
import 'package:ditonton/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies usecase;
  NowPlayingMovieBloc({required this.usecase})
      : super(NowPlayingMovieInitial()) {
    on<NowPlayingMovieEvent>((event, emit) async {
      emit(NowPlayingMovieLoading());
      final result = await usecase.execute();

      result.fold(
        (failure) => emit(NowPlayingMovieError(failure.message)),
        (result) => emit(NowPlayingMovieLoaded(result)),
      );
    });
  }
}
