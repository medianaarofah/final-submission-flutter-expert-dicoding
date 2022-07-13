part of 'top_rated_movie_bloc.dart';

abstract class TopRatedMovieEvent extends Equatable {
  const TopRatedMovieEvent();
}

class OnTopRatedMovieAppearing extends TopRatedMovieEvent {
  @override
  List<Object?> get props => [];
}
