import 'package:bloc/bloc.dart';
import 'package:ditonton/features/movies/domain/entities/movie.dart';
import 'package:ditonton/features/movies/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
part 'recommendations_movie_event.dart';
part 'recommendations_movie_state.dart';

class RecommendationsMovieBloc
    extends Bloc<RecommendationsMovieEvent, RecommendationsMovieState> {
  final GetMovieRecommendations usecase;
  RecommendationsMovieBloc({required this.usecase})
      : super(RecommendationsMovieInitial()) {
    on<GetRecommendationsMovieEvent>((event, emit) async {
      emit(RecommendationsMovieLoading());
      final result = await usecase.execute(event.id);

      result.fold(
        (failure) => emit(RecommendationsMovieError(failure.message)),
        (result) => emit(RecommendationsMovieLoaded(result)),
      );
    });
  }
}
