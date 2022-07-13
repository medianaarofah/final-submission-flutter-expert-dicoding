part of 'tv_series_recommendations_bloc.dart';

abstract class TVSeriesRecommendationsEvent extends Equatable {
  const TVSeriesRecommendationsEvent();
}

class OnTVSeriesRecommendationsAppearing extends TVSeriesRecommendationsEvent {
  final int id;

  OnTVSeriesRecommendationsAppearing(this.id);

  @override
  List<Object?> get props => [];
}
