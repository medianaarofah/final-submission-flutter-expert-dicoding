import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovie;
  late NowPlayingMovieBloc bloc;

  setUp(() {
    mockGetNowPlayingMovie = MockGetNowPlayingMovies();
    bloc = NowPlayingMovieBloc(mockGetNowPlayingMovie);
  });

  group('Now Playing Movie Bloc Testing', () {
    test('initial state should be empty', () {
      expect(bloc.state, NowPlayingMovieEmpty());
    });

    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovie.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnNowPlayingMovieAppearing()),
      expect: () => [
        NowPlayingMovieLoading(),
        NowPlayingMovieHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovie.execute());
        return OnNowPlayingMovieAppearing().props;
      },
    );

    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'Should emit [Loading, Error] when data is unsuccessful to fetch',
      build: () {
        when(mockGetNowPlayingMovie.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnNowPlayingMovieAppearing()),
      expect: () => [
        NowPlayingMovieLoading(),
        NowPlayingMovieError('Server Failure'),
      ],
      verify: (bloc) => NowPlayingMovieLoading(),
    );
  });
}
