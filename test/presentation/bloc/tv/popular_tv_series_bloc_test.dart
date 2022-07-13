import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv/popular_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv_series.dart';
import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTVSeries])
void main() {
  late PopularTVSeriesBloc bloc;
  late MockGetPopularTVSeries mockGetPopularTVSeries;

  setUp(() {
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    bloc = PopularTVSeriesBloc(mockGetPopularTVSeries);
  });

  group('Popular TV Series Bloc Testing', () {
    test('initial state should be empty', () {
      expect(bloc.state, PopularTVSeriesEmpty());
    });

    blocTest<PopularTVSeriesBloc, PopularTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnPopularTVSeriesAppearing()),
      expect: () => [
        PopularTVSeriesLoading(),
        PopularTVSeriesHasData(testTVSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTVSeries.execute());
        return OnPopularTVSeriesAppearing().props;
      },
    );

    blocTest<PopularTVSeriesBloc, PopularTVSeriesState>(
      'Should emit [Loading, Error] when data is unsuccessful to fetch',
      build: () {
        when(mockGetPopularTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnPopularTVSeriesAppearing()),
      expect: () => [
        PopularTVSeriesLoading(),
        PopularTVSeriesError('Server Failure'),
      ],
      verify: (bloc) => PopularTVSeriesLoading(),
    );
  });
}
