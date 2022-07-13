import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TVSeriesModel extends Equatable {
  TVSeriesModel({
    required this.id,
    required this.name,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final int id;
  final String name;
  final String? backdropPath;
  final String? firstAirDate;
  final List<int> genreIds;
  final List<String> originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  factory TVSeriesModel.fromJson(Map<String, dynamic> json) => TVSeriesModel(
        id: json['id'],
        name: json['name'],
        backdropPath: json['backdrop_path'] ?? '',
        firstAirDate: json['first_air_date'],
        genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
        originCountry: List<String>.from(json['origin_country'].map((x) => x)),
        originalLanguage: json['original_language'],
        originalName: json['original_name'],
        overview: json['overview'],
        popularity: json['popularity'].toDouble(),
        posterPath: json['poster_path'] ?? '',
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "first_air_date": firstAirDate,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "name": name,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TVSeries toEntity() {
    return TVSeries(
      backdropPath: this.backdropPath,
      firstAirDate: this.firstAirDate,
      genreIds: this.genreIds,
      id: this.id,
      name: this.name,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        backdropPath,
        genreIds,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
