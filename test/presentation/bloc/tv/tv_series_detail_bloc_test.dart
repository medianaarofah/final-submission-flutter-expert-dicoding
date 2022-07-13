import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv_series.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTVSeriesDetail])
void main() {
  late TVSeriesDetailBloc bloc;
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;

  setUp(() {
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    bloc = TVSeriesDetailBloc(mockGetTVSeriesDetail);
  });

  group('TV Series Detail Bloc Testing', () {
    test('initial state should be empty', () {
      expect(bloc.state, TVSeriesDetailEmpty());
    });

    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testTVSeriesDetailResponseEntity));
        return bloc;
      },
      act: (bloc) => bloc.add(OnTVSeriesDetailAppearing(tId)),
      expect: () => [
        TVSeriesDetailLoading(),
        TVSeriesDetailHasData(testTVSeriesDetailResponseEntity),
      ],
      verify: (bloc) {
        verify(mockGetTVSeriesDetail.execute(tId));
        return OnTVSeriesDetailAppearing(tId).props;
      },
    );

    blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
      'Should emit [Loading, Error] when data is unsuccessful to fetch',
      build: () {
        when(mockGetTVSeriesDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnTVSeriesDetailAppearing(tId)),
      expect: () => [
        TVSeriesDetailLoading(),
        TVSeriesDetailError('Server Failure'),
      ],
      verify: (bloc) => TVSeriesDetailLoading(),
    );
  });
}
