import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tvs/domain/entities/tv_detail.dart';
import 'package:ditonton/features/tvs/domain/repositories/tv_repository.dart';

class SaveWatchlistTV {
  final TVRepository repository;

  SaveWatchlistTV(this.repository);

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return repository.saveWatchlistTV(tv);
  }
}
