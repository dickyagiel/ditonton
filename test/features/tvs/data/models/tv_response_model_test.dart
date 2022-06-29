import 'dart:convert';
import 'package:ditonton/features/tvs/data/models/tv_model.dart';
import 'package:ditonton/features/tvs/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../json_reader.dart';

void main() {
  final tTVModel = TVModel(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    firstAirDate: "2020-05-05",
    name: "Name",
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tTVResponseModel = TVResponse(tvList: <TVModel>[tTVModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv.json'));
      // act
      final result = TVResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "poster_path": "/path.jpg",
            "popularity": 1.0,
            "id": 1,
            "backdrop_path": "/path.jpg",
            "vote_average": 1.0,
            "overview": "Overview",
            "first_air_date": "2020-05-05",
            "genre_ids": [1, 2, 3, 4],
            "vote_count": 1,
            "name": "Name",
            "original_name": "Original Name"
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
