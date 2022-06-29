import 'package:bloc/bloc.dart';
import 'package:ditonton/features/tvs/domain/entities/tv.dart';
import 'package:ditonton/features/tvs/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';
part 'top_rate_tv_event.dart';
part 'top_rate_tv_state.dart';

class TopRateTvBloc extends Bloc<TopRateTvEvent, TopRateTvState> {
  final GetTopRatedTV getTopRateTv;
  TopRateTvBloc({required this.getTopRateTv}) : super(TopRateTvStateEmpty()) {
    on<TopRateTvEvent>((event, emit) async {
      emit(TopRateTvStateLoading());
      final result = await getTopRateTv.execute();
      result.fold(
        (failure) => emit(TopRateTvStateError(failure.message)),
        (result) => emit(TopRateTvStateLoaded(result)),
      );
    });
  }
}
