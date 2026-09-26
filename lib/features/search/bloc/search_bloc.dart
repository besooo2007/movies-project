import 'package:app/features/search/use_case/search_movies_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMoviesUseCase searchMoviesUseCase;

  SearchBloc({
    required this.searchMoviesUseCase,
  }) : super(SearchInitial()) {
    on<SearchMoviesRequested>(_searchMovies);
    on<ClearSearch>(_clearSearch);
  }

 

  Future<void> _searchMovies(
    SearchMoviesRequested event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final movies = await searchMoviesUseCase(
        query: query,
      );

      if (movies.isEmpty) {
        emit(SearchEmpty());
        return;
      }

      emit(
        SearchSuccess(
          movies: movies,
        ),
      );
    } catch (e) {
      emit(
        SearchFailure(
          message: e.toString(),
        ),
      );
    }
  }



  void _clearSearch(
    ClearSearch event,
    Emitter<SearchState> emit,
  ) {
    emit(SearchInitial());
  }
}