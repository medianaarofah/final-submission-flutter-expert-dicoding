import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_recommendations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv_series.dart';
import 'tv_series_recommendations_bloc_test.mocks.dart';

@GenerateMocks([GetTVSeriesRecommendations])
void main() {
  late TVSeriesRecommendationsBloc bloc;
  late MockGetTVSeriesRecommendations mockGetTVSeriesRecommendations;

  setUp(() {
    mockGetTVSeriesRecommendations = MockGetTVSeriesRecommendations();
    bloc = TVSeriesRecommendationsBloc(mockGetTVSeriesRecommendations);
  });

  group('TV Series Recommendations Bloc Testing', () {
    test('initial state should be empty', () {
      expect(bloc.state, TVSeriesRecommendationsEmpty());
    });

    blocTest<TVSeriesRecommendationsBloc, TVSeriesRecommendationsState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTVSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testTVSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnTVSeriesRecommendationsAppearing(tId)),
      expect: () => [
        TVSeriesRecommendationsLoading(),
        TVSeriesRecommendationsHasData(testTVSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetTVSeriesRecommendations.execute(tId));
        return OnTVSeriesRecommendationsAppearing(tId).props;
      },
    );

    blocTest<TVSeriesRecommendationsBloc, TVSeriesRecommendationsState>(
      'Should emit [Loading, Error] when data is unsuccessful to fetch',
      build: () {
        when(mockGetTVSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnTVSeriesRecommendationsAppearing(tId)),
      expect: () => [
        TVSeriesRecommendationsLoading(),
        TVSeriesRecommendationsError('Server Failure'),
      ],
      verify: (bloc) => TVSeriesRecommendationsLoading(),
    );
  });
}
