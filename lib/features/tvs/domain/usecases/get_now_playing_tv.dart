import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tvs/domain/entities/tv.dart';
import 'package:ditonton/features/tvs/domain/repositories/tv_repository.dart';

class GetNowPlayingTV {
  final TVRepository repository;

  GetNowPlayingTV(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getNowPlayingTV();
  }
}
