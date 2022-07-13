part of 'tv_series_recommendations_bloc.dart';

abstract class TVSeriesRecommendationsState extends Equatable {
  const TVSeriesRecommendationsState();

  @override
  List<Object> get props => [];
}

class TVSeriesRecommendationsEmpty extends TVSeriesRecommendationsState {
  @override
  List<Object> get props => [];
}

class TVSeriesRecommendationsError extends TVSeriesRecommendationsState {
  String message;
  TVSeriesRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class TVSeriesRecommendationsLoading extends TVSeriesRecommendationsState {
  @override
  List<Object> get props => [];
}

class TVSeriesRecommendationsHasData extends TVSeriesRecommendationsState {
  final List<TVSeries> result;

  TVSeriesRecommendationsHasData(this.result);

  @override
  List<Object> get props => [result];
}
