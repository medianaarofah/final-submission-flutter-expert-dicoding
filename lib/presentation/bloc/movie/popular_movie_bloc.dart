import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/entities/movie.dart';
part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies _getPopularMovies;

  PopularMovieBloc(this._getPopularMovies) : super(PopularMovieEmpty()) {
    on<OnPopularMovieAppearing>((event, emit) async {
      emit(PopularMovieLoading());

      final result = await _getPopularMovies.execute();

      result.fold((failure) {
        emit(PopularMovieError(failure.message));
      }, (data) {
        if (data.isEmpty) {
          emit(PopularMovieEmpty());
        } else {
          emit(PopularMovieHasData(data));
        }
      });
    });
  }
}
