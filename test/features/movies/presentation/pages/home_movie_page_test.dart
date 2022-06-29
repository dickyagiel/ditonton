import 'package:ditonton/features/movies/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/pages/home_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../dummy_data/dummy_objects.dart';

class MockNowPlayingMovieBloc extends Mock implements NowPlayingMovieBloc {}

class NowPlayingMovieStateFake extends Fake implements NowPlayingMovieState {}

class NowPlayingMovieEventFake extends Fake implements NowPlayingMovieEvent {}

class MockPopulerMovieBloc extends Mock implements PopularMovieBloc {}

class PopularMovieStateFake extends Fake implements PopularMovieState {}

class PopularMovieEventFake extends Fake implements PopularMovieEvent {}

class MockTopRatedMovieBloc extends Mock implements TopRatedMovieBloc {}

class TopRatedMovieStateFake extends Fake implements TopRatedMovieState {}

class TopRatedMovieEventFake extends Fake implements TopRatedMovieEvent {}

void main() {
  late MockNowPlayingMovieBloc mockNowPlayingMovieBloc;
  late MockPopulerMovieBloc mockPopulerMovieBloc;
  late MockTopRatedMovieBloc mockTopRatedMovieBloc;

  setUpAll(() {
    registerFallbackValue(NowPlayingMovieStateFake());
    registerFallbackValue(NowPlayingMovieEventFake());
    registerFallbackValue(PopularMovieStateFake());
    registerFallbackValue(PopularMovieEventFake());
    registerFallbackValue(TopRatedMovieStateFake());
    registerFallbackValue(TopRatedMovieEventFake());
  });

  setUp(() {
    mockNowPlayingMovieBloc = MockNowPlayingMovieBloc();
    mockPopulerMovieBloc = MockPopulerMovieBloc();
    mockTopRatedMovieBloc = MockTopRatedMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularMovieBloc>.value(value: mockPopulerMovieBloc),
        BlocProvider<NowPlayingMovieBloc>.value(value: mockNowPlayingMovieBloc),
        BlocProvider<TopRatedMovieBloc>.value(value: mockTopRatedMovieBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display progress bar when loading",
    (WidgetTester tester) async {
      //popular
      when(() => mockPopulerMovieBloc.stream)
          .thenAnswer(((_) => Stream.value(PopularMovieLoading())));
      when(() => mockPopulerMovieBloc.state).thenReturn(PopularMovieLoading());
      //now playing
      when(() => mockNowPlayingMovieBloc.stream)
          .thenAnswer((_) => Stream.value(NowPlayingMovieLoading()));
      when(() => mockNowPlayingMovieBloc.state)
          .thenReturn(NowPlayingMovieLoading());
      //top rated
      when(() => mockTopRatedMovieBloc.stream)
          .thenAnswer((_) => Stream.value(TopRatedMovieLoading()));
      when(() => mockTopRatedMovieBloc.state)
          .thenReturn(TopRatedMovieLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(progressFinder, findsNWidgets(3));
      expect(centerFinder, findsWidgets);
    },
  );

  testWidgets(
    "Page should display ListView when data is loaded",
    (WidgetTester tester) async {
      //popular
      when(() => mockPopulerMovieBloc.stream)
          .thenAnswer(((_) => Stream.value(PopularMovieLoaded(testMovieList))));
      when(() => mockPopulerMovieBloc.state)
          .thenReturn(PopularMovieLoaded(testMovieList));
      //now playing
      when(() => mockNowPlayingMovieBloc.stream).thenAnswer(
          (_) => Stream.value(NowPlayingMovieLoaded(testMovieList)));
      when(() => mockNowPlayingMovieBloc.state)
          .thenReturn(NowPlayingMovieLoaded(testMovieList));
      //top rated
      when(() => mockTopRatedMovieBloc.stream)
          .thenAnswer((_) => Stream.value(TopRatedMovieLoaded(testMovieList)));
      when(() => mockTopRatedMovieBloc.state)
          .thenReturn(TopRatedMovieLoaded(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(listViewFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    "Page should display text with message when Error",
    (WidgetTester tester) async {
      //popular
      when(() => mockPopulerMovieBloc.stream)
          .thenAnswer(((_) => Stream.value(PopularMovieError(tError))));
      when(() => mockPopulerMovieBloc.state)
          .thenReturn(PopularMovieError(tError));
      //now playing
      when(() => mockNowPlayingMovieBloc.stream)
          .thenAnswer((_) => Stream.value(NowPlayingMovieError(tError)));
      when(() => mockNowPlayingMovieBloc.state)
          .thenReturn(NowPlayingMovieError(tError));
      //top rated
      when(() => mockTopRatedMovieBloc.stream)
          .thenAnswer((_) => Stream.value(TopRatedMovieError(tError)));
      when(() => mockTopRatedMovieBloc.state)
          .thenReturn(TopRatedMovieError(tError));

      final textFinder = find.text("Failed");

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(textFinder, findsNWidgets(3));
    },
  );
}
