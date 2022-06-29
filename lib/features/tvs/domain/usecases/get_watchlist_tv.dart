import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tvs/domain/entities/tv.dart';
import 'package:ditonton/features/tvs/domain/repositories/tv_repository.dart';

class GetWatchlistTV {
  final TVRepository _repository;

  GetWatchlistTV(this._repository);

  Future<Either<Failure, List<TV>>> execute() {
    return _repository.getWatchlistTV();
  }
}
