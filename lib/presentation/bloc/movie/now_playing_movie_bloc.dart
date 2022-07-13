import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/entities/movie.dart';
part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMovieBloc(this._getNowPlayingMovies)
      : super(NowPlayingMovieEmpty()) {
    on<OnNowPlayingMovieAppearing>((event, emit) async {
      emit(NowPlayingMovieLoading());

      final result = await _getNowPlayingMovies.execute();

      result.fold((failure) {
        emit(NowPlayingMovieError(failure.message));
      }, (data) {
        if (data.isEmpty) {
          emit(NowPlayingMovieEmpty());
        } else {
          emit(NowPlayingMovieHasData(data));
        }
      });
    });
  }
}
