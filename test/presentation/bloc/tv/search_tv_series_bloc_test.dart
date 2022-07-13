import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv/search_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv_series.dart';
import 'search_tv_series_bloc_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late SearchTVSeriesBloc bloc;
  late MockSearchTVSeries mockSearchTVSeries;

  setUp(() {
    mockSearchTVSeries = MockSearchTVSeries();
    bloc = SearchTVSeriesBloc(mockSearchTVSeries);
  });

  group('Search TV Series Bloc Testing', () {
    test('initial state should be empty', () {
      expect(bloc.state, SearchTVSeriesEmpty());
    });

    blocTest<SearchTVSeriesBloc, SearchTVSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchTVSeries.execute(tQuery))
            .thenAnswer((_) async => Right(testTVSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTVSeriesLoading(),
        SearchTVSeriesHasData(testTVSeriesList),
      ],
      verify: (bloc) {
        verify(mockSearchTVSeries.execute(tQuery));
      },
    );

    blocTest<SearchTVSeriesBloc, SearchTVSeriesState>(
      'Should emit [Loading, Error] when data is unsuccessful to fetch',
      build: () {
        when(mockSearchTVSeries.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTVSeriesLoading(),
        SearchTVSeriesError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTVSeries.execute(tQuery));
      },
    );
  });
}
