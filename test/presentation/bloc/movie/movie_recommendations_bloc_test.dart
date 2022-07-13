import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationsBloc bloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    bloc = MovieRecommendationsBloc(mockGetMovieRecommendations);
  });

  group('Movie Recommendations Bloc Testing', () {
    test('initial state should be empty', () {
      expect(bloc.state, MovieRecommendationsEmpty());
    });

    blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnRecommendationsMovieAppearing(tId)),
      expect: () => [
        MovieRecommendationsLoading(),
        MovieRecommendationsHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
        return OnRecommendationsMovieAppearing(tId).props;
      },
    );

    blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
      'Should emit [Loading, Error] when data is unsuccessful to fetch',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnRecommendationsMovieAppearing(tId)),
      expect: () => [
        MovieRecommendationsLoading(),
        MovieRecommendationsError('Server Failure'),
      ],
      verify: (bloc) => MovieRecommendationsLoading(),
    );
  });
}
