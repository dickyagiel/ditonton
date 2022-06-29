import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/features/movies/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/features/movies/presentation/bloc/watchlist_movie_status/watchlist_movie_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_status_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatus])
void main() {
  late MockGetWatchListStatus usecase;
  late WatchlistMovieStatusBloc bloc;

  setUp(() {
    usecase = MockGetWatchListStatus();
    bloc = WatchlistMovieStatusBloc(usecase: usecase);
  });

  test('initial state should be empty', () {
    expect(bloc.state, WatchlistMovieStatusInitial());
  });

  blocTest<WatchlistMovieStatusBloc, WatchlistMovieStatusState>(
    'Should emit [Loading, TrueState] when data is true',
    build: () {
      when(usecase.execute(tId)).thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(GetWatchlistMovieStatusEvent(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      WatchlistMovieStatusTrue(),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
    },
  );

  blocTest<WatchlistMovieStatusBloc, WatchlistMovieStatusState>(
    'Should emit [Loading, FalseState] when data is false',
    build: () {
      when(usecase.execute(tId)).thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(GetWatchlistMovieStatusEvent(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      WatchlistMovieStatusFalse(),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
    },
  );
}
