import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late FakePopularMovieBloc fakePopularMovieBloc;

  setUp(() {
    registerFallbackValue(FakePopularMovieEvent());
    registerFallbackValue(FakePopularMovieState());

    fakePopularMovieBloc = FakePopularMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>(
      create: (_) => fakePopularMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakePopularMovieBloc.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakePopularMovieBloc.state).thenReturn(PopularMovieLoading());

    final viewProgressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);
    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
    expect(centerFinder, findsOneWidget);
    expect(viewProgressFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => fakePopularMovieBloc.state).thenReturn(PopularMovieLoading());

    final viewProgressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);
    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
    expect(viewProgressFinder, findsOneWidget);
    expect(centerFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => fakePopularMovieBloc.stream)
        .thenAnswer(((_) => Stream.value(PopularMovieError('Server Failure'))));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularMovieError('Server Failure'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}

class FakePopularMovieEvent extends Fake implements PopularMovieEvent {}

class FakePopularMovieState extends Fake implements PopularMovieState {}

class FakePopularMovieBloc
    extends MockBloc<PopularMovieEvent, PopularMovieState>
    implements PopularMovieBloc {}
