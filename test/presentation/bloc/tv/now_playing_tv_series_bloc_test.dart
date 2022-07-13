import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv/now_playing_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv_series.dart';
import 'now_playing_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTVSeries])
void main() {
  late NowPlayingTVSeriesBloc bloc;
  late MockGetNowPlayingTVSeries mockGetNowPlayingTVSeries;

  setUp(() {
    mockGetNowPlayingTVSeries = MockGetNowPlayingTVSeries();
    bloc = NowPlayingTVSeriesBloc(mockGetNowPlayingTVSeries);
  });
  group('Now Playing TV Series Bloc Testing', () {
    test('initial state should be empty', () {
      expect(bloc.state, NowPlayingTVSeriesEmpty());
    });

    blocTest<NowPlayingTVSeriesBloc, NowPlayingTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnNowPlayingTVSeriesAppearing()),
      expect: () => [
        NowPlayingTVSeriesLoading(),
        NowPlayingTVSeriesHasData(testTVSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTVSeries.execute());
        return OnNowPlayingTVSeriesAppearing().props;
      },
    );

    blocTest<NowPlayingTVSeriesBloc, NowPlayingTVSeriesState>(
      'Should emit [Loading, Error] when data is unsuccessful to fetch',
      build: () {
        when(mockGetNowPlayingTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnNowPlayingTVSeriesAppearing()),
      expect: () => [
        NowPlayingTVSeriesLoading(),
        NowPlayingTVSeriesError('Server Failure'),
      ],
      verify: (bloc) => NowPlayingTVSeriesLoading(),
    );
  });
}
