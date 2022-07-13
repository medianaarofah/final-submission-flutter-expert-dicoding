import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:ditonton/data/models/tv_series_season_model.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

final testTVSeriesModel = TVSeriesModel(
    backdropPath: "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
    firstAirDate: "2022-03-24",
    genreIds: [10759, 10765],
    id: 52814,
    name: "Halo",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Halo",
    overview:
        "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
    popularity: 7348.55,
    posterPath: "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
    voteAverage: 8.7,
    voteCount: 472);

final testTVSeriesModelList = <TVSeriesModel>[testTVSeriesModel];
final testTVSeries = testTVSeriesModel.toEntity();
final testTVSeriesList = <TVSeries>[testTVSeries];
final testTVSeriesResponse =
    TVSeriesResponse(listTVSeries: testTVSeriesModelList);

final testTVSeriesDetailResponse = TVSeriesDetailResponse(
  adult: false,
  backdropPath: '',
  genres: [GenreModel(id: 1, name: 'Action')],
  id: 2,
  episodeRunTime: [],
  homepage: "https://google.com",
  numberOfEpisodes: 34,
  name: 'name',
  numberOfSeasons: 2,
  originalLanguage: 'en',
  originalName: 'name',
  overview: 'overview',
  popularity: 12.323,
  posterPath: '',
  seasons: [
    TVSeriesSeasonModel(
      airDate: '',
      episodeCount: 7,
      id: 1,
      name: 'Winter',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 2,
    )
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'Scripted',
  voteAverage: 3,
  voteCount: 3,
);

final testTVSeriesDetailResponseEntity = testTVSeriesDetailResponse.toEntity();
final testTVSeriesTable =
    TVSeriesTable.fromEntity(testTVSeriesDetailResponseEntity);
final testTVSeriesTableList = <TVSeriesTable>[testTVSeriesTable];
final testWatchlistTVSeries = [testTVSeriesTable.toEntity()];

final testTVSeriesMaping = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testTVSeriesDetail = TVSeriesDetailResponse(
  adult: false,
  popularity: 1,
  posterPath: 'posterPath',
  name: 'name',
  type: 'type',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  seasons: [],
  episodeRunTime: [1],
  genres: [],
  id: 1,
  overview: 'overview',
  voteCount: 1,
  tagline: 'tagline',
  originalName: 'originalName',
  homepage: 'homepage',
  voteAverage: 1,
  originalLanguage: 'originalLanguage',
  backdropPath: 'backdropPath',
  status: 'status',
);

final testTVSeriesDetailEntity = testTVSeriesDetail.toEntity();
final testTVSeriesMap = testTVSeriesDetail.toJson();

final testTVSeriesSeasonModel = TVSeriesSeasonModel(
  id: 1,
  name: 'season',
  posterPath: 'poster',
  episodeCount: 2,
  seasonNumber: 2,
  airDate: '',
  overview: '',
);

final testSeason = testTVSeriesSeasonModel.toEntity();
final testSeasonMap = testTVSeriesSeasonModel.toJson();
final tQuery = "Spider Man";
final tError = 'Server Failure';
final tId = 1;
