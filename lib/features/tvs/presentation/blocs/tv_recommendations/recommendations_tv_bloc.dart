import 'package:bloc/bloc.dart';
import 'package:ditonton/features/tvs/domain/entities/tv.dart';
import 'package:ditonton/features/tvs/domain/usecases/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';
part 'recommendations_tv_event.dart';
part 'recommendations_tv_state.dart';

class RecommendationsTvBloc
    extends Bloc<RecommendationsTvEvent, RecommendationsTvState> {
  final GetTVRecommendations getTvRecommendations;
  RecommendationsTvBloc({required this.getTvRecommendations})
      : super(RecommendationsTvStateEmpty()) {
    on<RecommendationsTv>((event, emit) async {
      emit(RecommendationsTvStateLoading());
      final result = await getTvRecommendations.execute(event.id);

      result.fold(
        (failure) => emit(RecommendationsTvStateError(failure.message)),
        (result) => emit(RecommendationsTvStateLoaded(result)),
      );
    });
  }
}
