part of 'movie_recommendations_bloc.dart';

abstract class MovieRecommendationsEvent extends Equatable {
  const MovieRecommendationsEvent();
}

class OnRecommendationsMovieAppearing extends MovieRecommendationsEvent {
  final int id;

  OnRecommendationsMovieAppearing(this.id);

  @override
  List<Object?> get props => [];
}
