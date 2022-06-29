import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movies/domain/usecases/search_movies.dart';
import 'package:ditonton/features/movies/presentation/bloc/search_tv/search_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../dummy_data/dummy_objects.dart';
import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies usecase;
  late SearchMovieBloc bloc;

  setUp(() {
    usecase = MockSearchMovies();
    bloc = SearchMovieBloc(usecase: usecase);
  });

  test('initial state should be empty', () {
    expect(bloc.state, SearchMovieInitial());
  });

  blocTest<SearchMovieBloc, SearchMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute(tQuery))
          .thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetSearchMovieEvent(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchMovieLoading(),
      SearchMovieLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(usecase.execute(tQuery));
    },
  );

  blocTest<SearchMovieBloc, SearchMovieState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(usecase.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetSearchMovieEvent(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchMovieLoading(),
      SearchMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(usecase.execute(tQuery));
    },
  );
}
