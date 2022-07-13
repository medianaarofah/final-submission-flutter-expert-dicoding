import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTVSeriesModel = TVSeriesModel(
    backdropPath: 'backdropPath',
    firstAirDate: "2021-09-03",
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ["US"],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 18.591,
    posterPath: 'posterPath',
    voteAverage: 9.4,
    voteCount: 2710,
  );

  final tTVSeries = TVSeries(
    backdropPath: 'backdropPath',
    firstAirDate: "2021-09-03",
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ["US"],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 18.591,
    posterPath: 'posterPath',
    voteAverage: 9.4,
    voteCount: 2710,
  );

  test('should be a subclass of TV Series entity', () async {
    final result = tTVSeriesModel.toEntity();
    expect(result, tTVSeries);
  });
}
