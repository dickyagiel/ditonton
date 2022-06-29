import 'package:ditonton/features/movies/data/datasources/db/database_helper.dart';
import 'package:ditonton/features/movies/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/features/movies/domain/repositories/movie_repository.dart';
import 'package:ditonton/features/tvs/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/features/tvs/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/features/tvs/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TVRepository,
  TVRemoteDataSource,
  TVLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
