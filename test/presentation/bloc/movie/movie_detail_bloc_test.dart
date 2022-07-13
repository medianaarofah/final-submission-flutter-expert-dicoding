import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MovieDetailBloc bloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    bloc = MovieDetailBloc(mockGetMovieDetail);
  });

  group('Movie Detail Bloc Testing', () {
    test('initial state should be empty', () {
      expect(bloc.state, MovieDetailEmpty());
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(OnDetailMovieAppearing(tId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailHasData(testMovieDetail),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        return OnDetailMovieAppearing(tId).props;
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Error] when data is unsucessful to fetch',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnDetailMovieAppearing(tId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailError('Server Failure'),
      ],
      verify: (bloc) => MovieDetailLoading(),
    );
  });
}
