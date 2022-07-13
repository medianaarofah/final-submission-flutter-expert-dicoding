import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv_series.dart';
import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late TopRatedTVSeriesBloc bloc;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;

  setUp(() {
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    bloc = TopRatedTVSeriesBloc(mockGetTopRatedTVSeries);
  });

  group('Top Rated TV Series Bloc Testing', () {
    test('initial state should be empty', () {
      expect(bloc.state, TopRatedTVSeriesEmpty());
    });

    blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnTopRatedTVSeriesAppearing()),
      expect: () => [
        TopRatedTVSeriesLoading(),
        TopRatedTVSeriesHasData(testTVSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
        return OnTopRatedTVSeriesAppearing().props;
      },
    );

    blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
      'Should emit [Loading, Error] when data is unsuccessful to fetch',
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnTopRatedTVSeriesAppearing()),
      expect: () => [
        TopRatedTVSeriesLoading(),
        TopRatedTVSeriesError('Server Failure'),
      ],
      verify: (bloc) => TopRatedTVSeriesLoading(),
    );
  });
}
