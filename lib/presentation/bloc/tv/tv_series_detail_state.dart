part of 'tv_series_detail_bloc.dart';

abstract class TVSeriesDetailState extends Equatable {
  const TVSeriesDetailState();

  @override
  List<Object> get props => [];
}

class TVSeriesDetailEmpty extends TVSeriesDetailState {
  @override
  List<Object> get props => [];
}

class TVSeriesDetailLoading extends TVSeriesDetailState {
  @override
  List<Object> get props => [];
}

class TVSeriesDetailError extends TVSeriesDetailState {
  String message;

  TVSeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TVSeriesDetailHasData extends TVSeriesDetailState {
  final TVSeriesDetail result;

  TVSeriesDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
