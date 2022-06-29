import 'package:ditonton/features/movies/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/features/movies/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../dummy_data/dummy_objects.dart';

class MockPopulerMovieBloc extends Mock implements PopularMovieBloc {}

class PopularMovieStateFake extends Fake implements PopularMovieState {}

class PopularMovieEventFake extends Fake implements PopularMovieEvent {}

void main() {
  late MockPopulerMovieBloc bloc;

  setUpAll(() {
    registerFallbackValue(PopularMovieStateFake());
    registerFallbackValue(PopularMovieEventFake());
  });

  setUp(() {
    bloc = MockPopulerMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display center progress bar when loading",
    (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer(((_) => Stream.value(PopularMovieLoading())));
      when(() => bloc.state).thenReturn(PopularMovieLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(progressBarFinder, findsOneWidget);
      expect(centerFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display ListView when data is loaded",
    (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer(((_) => Stream.value(PopularMovieLoaded(testMovieList))));
      when(() => bloc.state).thenReturn(PopularMovieLoaded(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text with message when Error",
    (WidgetTester tester) async {
      when(() => bloc.stream).thenAnswer(
          ((_) => Stream.value(PopularMovieError('Server Failure'))));
      when(() => bloc.state).thenReturn(PopularMovieError('Server Failure'));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
