import 'package:app/features/home_api/domin/use_case/get_movies_usecase.dart';
import 'package:bloc/bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMovies getMovies;

  HomeBloc(this.getMovies) : super(HomeInitial()) {
    on<GetMoviesRequested>(_getMovies);
  }

  Future<void> _getMovies(
    GetMoviesRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      final movies = await getMovies();

      emit(HomeSuccess(movies));
    } catch (e) {
      emit(HomeFailure('Something went wrong'));
    }
  }
}
