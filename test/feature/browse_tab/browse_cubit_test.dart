import 'package:app/feature/browse%20tab/domain/entities/movie_entity.dart';
import 'package:app/feature/browse%20tab/domain/repositories/browse_repository.dart';
import 'package:app/feature/browse%20tab/domain/usecases/get_movies_usecase.dart';
import 'package:app/feature/browse%20tab/presentation/controller/browse_cubit.dart';
import 'package:app/feature/browse%20tab/presentation/controller/browse_state.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeBrowseRepository implements BrowseRepository {
  List<MovieEntity>? moviesToReturn;
  Exception? exceptionToThrow;
  int callCount = 0;

  @override
  Future<List<MovieEntity>> getMovies() async {
    callCount++;
    if (exceptionToThrow != null) {
      throw exceptionToThrow!;
    }
    return moviesToReturn ?? [];
  }
}

void main() {
  late FakeBrowseRepository fakeRepository;
  late GetMoviesUseCase getMoviesUseCase;
  late BrowseCubit browseCubit;

  final sampleMovies = [
    const MovieEntity(
      id: 1,
      title: 'Movie A',
      titleEnglish: 'Movie A',
      year: 2024,
      rating: 8.5,
      runtime: 120,
      genres: ['Action', 'Drama'],
      summary: 'Action and Drama movie',
      mediumCoverImage: 'https://example.com/a.jpg',
      largeCoverImage: 'https://example.com/a_large.jpg',
    ),
    const MovieEntity(
      id: 2,
      title: 'Movie B',
      titleEnglish: 'Movie B',
      year: 2023,
      rating: 7.2,
      runtime: 95,
      genres: ['Comedy'],
      summary: 'Comedy movie',
      mediumCoverImage: 'https://example.com/b.jpg',
      largeCoverImage: 'https://example.com/b_large.jpg',
    ),
    const MovieEntity(
      id: 3,
      title: 'Movie C',
      titleEnglish: 'Movie C',
      year: 2022,
      rating: 6.8,
      runtime: 110,
      genres: ['Action', 'Thriller'],
      summary: 'Action and Thriller movie',
      mediumCoverImage: 'https://example.com/c.jpg',
      largeCoverImage: 'https://example.com/c_large.jpg',
    ),
    const MovieEntity(
      id: 4,
      title: 'Movie D',
      titleEnglish: 'Movie D',
      year: 2021,
      rating: 7.9,
      runtime: 105,
      genres: ['Drama', 'Romance'],
      summary: 'Drama and Romance movie',
      mediumCoverImage: 'https://example.com/d.jpg',
      largeCoverImage: 'https://example.com/d_large.jpg',
    ),
  ];

  setUp(() {
    fakeRepository = FakeBrowseRepository();
    getMoviesUseCase = GetMoviesUseCase(repository: fakeRepository);
    browseCubit = BrowseCubit(getMoviesUseCase: getMoviesUseCase);
  });

  tearDown(() {
    browseCubit.close();
  });

  test('Initial state is BrowseInitial', () {
    expect(browseCubit.state, isA<BrowseInitial>());
  });

  test(
      'fetchMovies extracts unique genres using Set, defaults to first genre, and filters correctly',
      () async {
    fakeRepository.moviesToReturn = sampleMovies;

    expectLater(
      browseCubit.stream,
      emitsInOrder([
        isA<BrowseLoading>(),
        isA<BrowseSuccess>(),
      ]),
    );

    await browseCubit.fetchMovies();

    final successState = browseCubit.state as BrowseSuccess;

    // Genres must have duplicates removed: Action, Drama, Comedy, Thriller, Romance (5 unique)
    expect(successState.genres, ['Action', 'Drama', 'Comedy', 'Thriller', 'Romance']);
    expect(successState.selectedGenre, 'Action');

    // Filtered movies for 'Action' must include Movie A and Movie C
    expect(successState.filteredMovies.map((m) => m.title).toList(), ['Movie A', 'Movie C']);
    expect(fakeRepository.callCount, 1);
  });

  test(
      'selectGenre filters movies locally without triggering another repository call',
      () async {
    fakeRepository.moviesToReturn = sampleMovies;
    await browseCubit.fetchMovies();
    expect(fakeRepository.callCount, 1);

    // Select 'Drama'
    browseCubit.selectGenre('Drama');
    var successState = browseCubit.state as BrowseSuccess;
    expect(successState.selectedGenre, 'Drama');
    // Drama should contain Movie A and Movie D
    expect(successState.filteredMovies.map((m) => m.title).toList(), ['Movie A', 'Movie D']);
    expect(fakeRepository.callCount, 1); // No new network call!

    // Select 'Comedy'
    browseCubit.selectGenre('Comedy');
    successState = browseCubit.state as BrowseSuccess;
    expect(successState.selectedGenre, 'Comedy');
    expect(successState.filteredMovies.map((m) => m.title).toList(), ['Movie B']);
    expect(fakeRepository.callCount, 1); // Still 1 call!

    // Select 'Thriller'
    browseCubit.selectGenre('Thriller');
    successState = browseCubit.state as BrowseSuccess;
    expect(successState.selectedGenre, 'Thriller');
    expect(successState.filteredMovies.map((m) => m.title).toList(), ['Movie C']);
    expect(fakeRepository.callCount, 1); // Still 1 call!
  });

  test('Multi-genre movies appear under every matching category', () async {
    fakeRepository.moviesToReturn = sampleMovies;
    await browseCubit.fetchMovies();

    // Movie A has ['Action', 'Drama']
    browseCubit.selectGenre('Action');
    var successState = browseCubit.state as BrowseSuccess;
    expect(successState.filteredMovies.any((m) => m.title == 'Movie A'), isTrue);

    browseCubit.selectGenre('Drama');
    successState = browseCubit.state as BrowseSuccess;
    expect(successState.filteredMovies.any((m) => m.title == 'Movie A'), isTrue);
  });

  test('fetchMovies emits BrowseError when repository throws', () async {
    fakeRepository.exceptionToThrow = Exception('Network error');

    expectLater(
      browseCubit.stream,
      emitsInOrder([
        isA<BrowseLoading>(),
        isA<BrowseError>(),
      ]),
    );

    await browseCubit.fetchMovies();

    expect(browseCubit.state, isA<BrowseError>());
    expect((browseCubit.state as BrowseError).message, contains('Network error'));
  });
}
