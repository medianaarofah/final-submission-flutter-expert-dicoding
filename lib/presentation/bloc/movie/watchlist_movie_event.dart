part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();
}

class OnWatchlistMovie extends WatchlistMovieEvent {
  @override
  List<Object> get props => [];
}

class WatchlistMovie extends WatchlistMovieEvent {
  final int id;

  WatchlistMovie(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movie;

  AddWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class DeleteWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movie;

  DeleteWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}
