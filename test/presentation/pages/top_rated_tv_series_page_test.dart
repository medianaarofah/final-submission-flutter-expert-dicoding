import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late FakeTopRatedTVSeriesBloc fakeTopRatedTVSeriesBloc;

  setUp(() {
    registerFallbackValue(FakeTopRatedTVSeriesEvent());
    registerFallbackValue(FakeTopRatedTVSeriesState());

    fakeTopRatedTVSeriesBloc = FakeTopRatedTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTVSeriesBloc>(
      create: (_) => fakeTopRatedTVSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTVSeriesBloc.state)
        .thenReturn(TopRatedTVSeriesLoading());

    final viewProgressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesPage()));
    expect(centerFinder, findsOneWidget);
    expect(viewProgressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTVSeriesBloc.state)
        .thenReturn(TopRatedTVSeriesLoading());

    final viewProgressFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesPage()));
    expect(listViewFinder, findsOneWidget);
    expect(viewProgressFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTVSeriesBloc.stream).thenAnswer(
        ((_) => Stream.value(TopRatedTVSeriesError('Server Failure'))));
    when(() => fakeTopRatedTVSeriesBloc.state)
        .thenReturn(TopRatedTVSeriesError('Server Failure'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}

// fake class for top rated tv series

class FakeTopRatedTVSeriesEvent extends Fake implements TopRatedTVSeriesEvent {}

class FakeTopRatedTVSeriesState extends Fake implements TopRatedTVSeriesState {}

class FakeTopRatedTVSeriesBloc
    extends MockBloc<TopRatedTVSeriesEvent, TopRatedTVSeriesState>
    implements TopRatedTVSeriesBloc {}
