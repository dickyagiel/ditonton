import 'package:ditonton/features/tvs/presentation/blocs/popular_tv/popular_tv_bloc.dart';
import 'package:ditonton/features/tvs/presentation/pages/popular_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../dummy_data/dummy_objects.dart';

class MockPopularTvBloc extends Mock implements PopularTvBloc {}

class FakeEvent extends Fake implements PopularTvEvent {}

class FakeState extends Fake implements PopularTvState {}

void main() {
  late MockPopularTvBloc bloc;

  setUpAll(() {
    registerFallbackValue(FakeEvent());
    registerFallbackValue(FakeState());
  });

  setUp(() {
    bloc = MockPopularTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>.value(
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
          .thenAnswer(((_) => Stream.value(PopularTvStateLoading())));
      when(() => bloc.state).thenReturn(PopularTvStateLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

      expect(progressBarFinder, findsOneWidget);
      expect(centerFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display ListView when data is loaded",
    (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer(((_) => Stream.value(PopularTvStateLoaded(testTVList))));
      when(() => bloc.state).thenReturn(PopularTvStateLoaded(testTVList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text with message when Error",
    (WidgetTester tester) async {
      when(() => bloc.stream).thenAnswer(
          ((_) => Stream.value(PopularTvStateError('Server Failure'))));
      when(() => bloc.state).thenReturn(PopularTvStateError('Server Failure'));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
