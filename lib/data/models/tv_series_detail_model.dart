import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_series_season_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetailResponse extends Equatable {
  TVSeriesDetailResponse({
    required this.id,
    required this.name,
    required this.adult,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.genres,
    required this.homepage,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  final int id;
  final String name;
  final bool adult;
  final String? backdropPath;
  final List<int> episodeRunTime;
  final List<GenreModel> genres;
  final List<TVSeriesSeasonModel> seasons;
  final String homepage;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  factory TVSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TVSeriesDetailResponse(
        id: json["id"],
        name: json["name"],
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        seasons: List<TVSeriesSeasonModel>.from(
            json["seasons"].map((x) => TVSeriesSeasonModel.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "adult": adult,
        "backdrop_path": backdropPath,
        "episode_run_time": episodeRunTime,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TVSeriesDetail toEntity() {
    return TVSeriesDetail(
      id: this.id,
      name: this.name,
      adult: this.adult,
      backdropPath: this.backdropPath,
      episodeRunTime: this.episodeRunTime,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      overview: this.overview,
      posterPath: this.posterPath,
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      seasons: this.seasons.map((season) => season.toEntity()).toList(),
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        adult,
        backdropPath,
        episodeRunTime,
        genres,
        homepage,
        numberOfEpisodes,
        numberOfSeasons,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        seasons,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
