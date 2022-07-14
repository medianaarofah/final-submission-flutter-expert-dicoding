import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late FakePopularTVSeriesBloc fakePopularTVSeriesBloc;

  setUp(() {
    registerFallbackValue(FakePopularTVSeriesEvent());
    registerFallbackValue(FakePopularTVSeriesState());

    fakePopularTVSeriesBloc = FakePopularTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTVSeriesBloc>(
      create: (_) => fakePopularTVSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakePopularTVSeriesBloc.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakePopularTVSeriesBloc.state)
        .thenReturn(PopularTVSeriesLoading());

    final viewProgressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesPage()));
    expect(centerFinder, findsOneWidget);
    expect(viewProgressFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakePopularTVSeriesBloc.state)
        .thenReturn(PopularTVSeriesLoading());

    final viewProgressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesPage()));
    expect(viewProgressFinder, findsOneWidget);
    expect(centerFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakePopularTVSeriesBloc.stream).thenAnswer(
        ((_) => Stream.value(PopularTVSeriesError('Server Failure'))));
    when(() => fakePopularTVSeriesBloc.state)
        .thenReturn(PopularTVSeriesError('Server Failure'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTVSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}

// fake class for popular tv series

class FakePopularTVSeriesEvent extends Fake implements PopularTVSeriesEvent {}

class FakePopularTVSeriesState extends Fake implements PopularTVSeriesState {}

class FakePopularTVSeriesBloc
    extends MockBloc<PopularTVSeriesEvent, PopularTVSeriesState>
    implements PopularTVSeriesBloc {}
