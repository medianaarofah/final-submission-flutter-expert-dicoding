part of 'movie_recommendations_bloc.dart';

abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object> get props => [];
}

class MovieRecommendationsEmpty extends MovieRecommendationsState {
  @override
  List<Object> get props => [];
}

class MovieRecommendationsError extends MovieRecommendationsState {
  String message;
  MovieRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecommendationsLoading extends MovieRecommendationsState {
  @override
  List<Object> get props => [];
}

class MovieRecommendationsHasData extends MovieRecommendationsState {
  final List<Movie> result;

  MovieRecommendationsHasData(this.result);

  @override
  List<Object> get props => [result];
}
