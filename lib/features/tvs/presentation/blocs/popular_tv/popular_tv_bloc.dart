import 'package:bloc/bloc.dart';
import 'package:ditonton/features/tvs/domain/entities/tv.dart';
import 'package:ditonton/features/tvs/domain/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';
part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTV getPopularTv;
  PopularTvBloc({required this.getPopularTv}) : super(PopularTvStateEmpty()) {
    on<PopularTvEvent>((event, emit) async {
      emit(PopularTvStateLoading());
      final result = await getPopularTv.execute();

      result.fold(
        (failure) => emit(PopularTvStateError(failure.message)),
        (result) => emit(PopularTvStateLoaded(result)),
      );
    });
  }
}
