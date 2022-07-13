import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchListStatus _getWatchListStatus;
  final GetWatchlistMovies _getWatchlistMovies;
  final RemoveWatchlist _removeWatchlist;
  final SaveWatchlist _saveWatchlist;

  WatchlistMovieBloc(
    this._getWatchListStatus,
    this._getWatchlistMovies,
    this._removeWatchlist,
    this._saveWatchlist,
  ) : super(WatchlistMovieEmpty()) {
    on<OnWatchlistMovie>((event, emit) async {
      emit(WatchlistMovieLoading());

      final result = await _getWatchlistMovies.execute();

      result.fold((failure) {
        emit(WatchlistMovieError(failure.message));
      }, (data) {
        if (data.isEmpty) {
          emit(WatchlistMovieEmpty());
        } else {
          emit(WatchlistMovieHasData(data));
        }
      });
    });

    on<WatchlistMovie>((event, emit) async {
      final id = event.id;

      final result = await _getWatchListStatus.execute(id);

      emit(AddWatchlist(result));
    });

    on<AddWatchlistMovie>((event, emit) async {
      emit(WatchlistMovieLoading());

      final movie = event.movie;

      final result = await _saveWatchlist.execute(movie);

      result.fold((failure) {
        emit(WatchlistMovieError(failure.message));
      }, (message) {
        emit(MessageWatchlist(message));
      });
    });

    on<DeleteWatchlistMovie>((event, emit) async {
      final movie = event.movie;

      final result = await _removeWatchlist.execute(movie);

      result.fold((failure) {
        emit(WatchlistMovieError(failure.message));
      }, (message) {
        emit(MessageWatchlist(message));
      });
    });
  }
}
