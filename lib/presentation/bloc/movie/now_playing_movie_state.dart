part of 'now_playing_movie_bloc.dart';

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object> get props => [];
}

class NowPlayingMovieEmpty extends NowPlayingMovieState {
  @override
  List<Object> get props => [];
}

class NowPlayingMovieLoading extends NowPlayingMovieState {
  @override
  List<Object> get props => [];
}

class NowPlayingMovieError extends NowPlayingMovieState {
  final String message;

  NowPlayingMovieError(this.message);
}

class NowPlayingMovieHasData extends NowPlayingMovieState {
  final List<Movie> result;

  NowPlayingMovieHasData(this.result);

  @override
  List<Object> get props => [];
}
