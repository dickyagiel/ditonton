import 'package:ditonton/features/tvs/presentation/blocs/top_rated_tv/top_rate_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/pages/top_rated_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../dummy_data/dummy_objects.dart';

class MockTopRatedTvBloc extends Mock implements TopRateTvBloc {}

class FakeEvent extends Fake implements TopRateTvEvent {}

class FakeState extends Fake implements TopRateTvState {}

void main() {
  late MockTopRatedTvBloc bloc;

  setUpAll(() {
    registerFallbackValue(FakeEvent());
    registerFallbackValue(FakeState());
  });

  setUp(() {
    bloc = MockTopRatedTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRateTvBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display progress bar when loading",
    (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer((_) => Stream.value(TopRateTvStateLoading()));
      when(() => bloc.state).thenReturn(TopRateTvStateLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTVPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display when data is loaded",
    (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer((_) => Stream.value(TopRateTvStateLoaded(testTVList)));
      when(() => bloc.state).thenReturn(TopRateTvStateLoaded(testTVList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTVPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text with message when Error",
    (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer((_) => Stream.value(TopRateTvStateError(tError)));
      when(() => bloc.state).thenReturn(TopRateTvStateError(tError));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedTVPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
