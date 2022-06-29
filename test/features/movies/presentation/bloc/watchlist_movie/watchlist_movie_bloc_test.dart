import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movies/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/features/movies/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies usecase;
  late WatchlistMovieBloc bloc;

  setUp(() {
    usecase = MockGetWatchlistMovies();
    bloc = WatchlistMovieBloc(getWatchlistMovies: usecase);
  });

  test('initial state should be empty', () {
    expect(bloc.state, WatchlistMovieInitial());
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetWatchlistMovieEvent()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetWatchlistMovieEvent()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(usecase.execute());
    },
  );
}
