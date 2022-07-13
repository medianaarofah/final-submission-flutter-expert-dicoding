import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_movie_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieBloc bloc;
  late MockGetTopRatedMovies mockGetTopRatedMovie;

  setUp(() {
    mockGetTopRatedMovie = MockGetTopRatedMovies();
    bloc = TopRatedMovieBloc(mockGetTopRatedMovie);
  });

  group('Top Rated Movie Bloc Testing', () {
    test('initial state should be empty', () {
      expect(bloc.state, TopRatedMovieEmpty());
    });

    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovie.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnTopRatedMovieAppearing()),
      expect: () => [
        TopRatedMovieLoading(),
        TopRatedMovieHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovie.execute());
        return OnTopRatedMovieAppearing().props;
      },
    );

    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'Should emit [Loading, Error] when data is unsuccessful to fetch',
      build: () {
        when(mockGetTopRatedMovie.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnTopRatedMovieAppearing()),
      expect: () => [
        TopRatedMovieLoading(),
        TopRatedMovieError('Server Failure'),
      ],
      verify: (bloc) => TopRatedMovieLoading(),
    );
  });
}
