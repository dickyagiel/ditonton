import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/features/movies/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../dummy_data/dummy_objects.dart';
import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies usecase;
  late PopularMovieBloc bloc;

  setUp(() {
    usecase = MockGetPopularMovies();
    bloc = PopularMovieBloc(usecase: usecase);
  });

  test('initial state should be empty', () {
    expect(bloc.state, PopularMovieInitial());
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetPopularMovieEvent()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
    },
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetPopularMovieEvent()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(usecase.execute());
    },
  );
}
