import 'package:bloc/bloc.dart';
import 'package:ditonton/features/tvs/domain/entities/tv_detail.dart';
import 'package:ditonton/features/tvs/domain/usecases/get_tv_detail.dart';
import 'package:equatable/equatable.dart';
part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTVDetail getTvDetail;
  TvDetailBloc({
    required this.getTvDetail,
  }) : super(TvDetailStateEmpty()) {
    on<TvDetail>((event, emit) async {
      emit(TvDetailStateLoading());
      final id = event.id;
      final result = await getTvDetail.execute(id);
      result.fold(
        (failure) => emit(TvDetailStateError(failure.message)),
        (result) => emit(TvDetailStateLoaded(result)),
      );
    });
  }
}
