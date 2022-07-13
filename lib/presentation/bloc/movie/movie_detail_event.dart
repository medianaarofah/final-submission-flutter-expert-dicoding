part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class OnDetailMovieAppearing extends MovieDetailEvent {
  final int id;

  OnDetailMovieAppearing(this.id);

  @override
  List<Object> get props => [];
}
