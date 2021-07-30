import '../../../../core/error/failure.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/news.dart';
import '../repositories/news_repository.dart';
import 'package:dartz/dartz.dart';

class GetFavoriteNews implements UseCase<List<News>, NoParams> {
  final NewsRepository _repository;

  GetFavoriteNews(this._repository);
  @override
  Future<Either<Failure, List<News>>> call(NoParams params) async {
    return await _repository.getFavoriteNews();
  }
}
