import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/entities/movie.dart';
part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovieBloc(this._getTopRatedMovies) : super(TopRatedMovieEmpty()) {
    on<TopRatedMovieEvent>((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await _getTopRatedMovies.execute();

      result.fold((failure) {
        emit(TopRatedMovieError(failure.message));
      }, (data) {
        if (data.isEmpty) {
          emit(TopRatedMovieEmpty());
        } else {
          emit(TopRatedMovieHasData(data));
        }
      });
    });
  }
}
