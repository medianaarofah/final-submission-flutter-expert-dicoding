import 'package:ditonton/domain/entities/tv_series_season.dart';
import 'package:equatable/equatable.dart';

class TVSeriesSeasonModel extends Equatable {
  final int id;
  final String name;
  final String? airDate;
  final int episodeCount;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  TVSeriesSeasonModel({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episodeCount,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory TVSeriesSeasonModel.fromJson(Map<String, dynamic> json) =>
      TVSeriesSeasonModel(
        id: json['id'],
        name: json['name'],
        airDate: json['air_date'],
        episodeCount: json['episode_count'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        seasonNumber: json['season_number'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "air_date": airDate,
        "episode_count": episodeCount,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  Season toEntity() => Season(
        id: this.id,
        name: this.name,
        posterPath: this.posterPath,
        seasonNumber: this.seasonNumber,
        episodeCount: this.episodeCount,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        airDate,
        episodeCount,
        overview,
        posterPath,
        seasonNumber,
      ];
}
