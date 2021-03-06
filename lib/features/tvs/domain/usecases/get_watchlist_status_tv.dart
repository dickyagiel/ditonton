import 'package:ditonton/features/tvs/domain/repositories/tv_repository.dart';

class GetWatchListStatusTV {
  final TVRepository repository;

  GetWatchListStatusTV(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
