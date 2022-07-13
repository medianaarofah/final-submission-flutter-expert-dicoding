import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovie;
  late PopularMovieBloc bloc;

  setUp(() {
    mockGetPopularMovie = MockGetPopularMovies();
    bloc = PopularMovieBloc(mockGetPopularMovie);
  });

  group('Popular Movie Bloc Testing', () {
    test('initial state should be empty', () {
      expect(bloc.state, PopularMovieEmpty());
    });

    blocTest<PopularMovieBloc, PopularMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovie.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnPopularMovieAppearing()),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovie.execute());
        return OnPopularMovieAppearing().props;
      },
    );

    blocTest<PopularMovieBloc, PopularMovieState>(
      'Should emit [Loading, Error] when data is unsuccessful to fetch',
      build: () {
        when(mockGetPopularMovie.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnPopularMovieAppearing()),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieError('Server Failure'),
      ],
      verify: (bloc) => PopularMovieLoading(),
    );
  });
}
