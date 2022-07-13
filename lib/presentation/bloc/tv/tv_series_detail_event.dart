part of 'tv_series_detail_bloc.dart';

abstract class TVSeriesDetailEvent extends Equatable {
  const TVSeriesDetailEvent();
}

class OnTVSeriesDetailAppearing extends TVSeriesDetailEvent {
  final int id;

  OnTVSeriesDetailAppearing(this.id);

  @override
  List<Object> get props => [];
}
