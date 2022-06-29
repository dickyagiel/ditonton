import 'package:bloc/bloc.dart';
import 'package:ditonton/features/tvs/domain/entities/tv.dart';
import 'package:ditonton/features/tvs/domain/usecases/search_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTV searchTv;
  SearchTvBloc({required this.searchTv}) : super(SearchTvStateEmpty()) {
    on<SearchTv>((event, emit) async {
      emit(SearchTvStateLoading());
      final query = event.query;
      final result = await searchTv.execute(query);

      result.fold(
        (failure) => emit(SearchTvStateError(failure.message)),
        (result) => emit(SearchTvStateLoaded(result)),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
