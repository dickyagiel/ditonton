import 'package:ditonton/features/movies/data/models/genre_model.dart';
import 'package:ditonton/features/tvs/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TVDetailResponse extends Equatable {
  TVDetailResponse({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.episodeRuntime,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<GenreModel> genres;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final List<dynamic> episodeRuntime;
  final String name;
  final double voteAverage;
  final int voteCount;

  factory TVDetailResponse.fromJson(Map<String, dynamic> json) =>
      TVDetailResponse(
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        originalName: json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        firstAirDate: json["first_air_date"],
        episodeRuntime: json["episode_run_time"],
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "first_air_date": firstAirDate,
        "episode_runtime": episodeRuntime,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TVDetail toEntity() {
    return TVDetail(
      backdropPath: this.backdropPath,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      originalName: this.originalName,
      overview: this.overview,
      posterPath: this.posterPath,
      firstAirDate: this.firstAirDate,
      episodeRuntime: this.episodeRuntime,
      name: this.name,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        originalName,
        overview,
        posterPath,
        firstAirDate,
        episodeRuntime,
        name,
        voteAverage,
        voteCount,
      ];
}
