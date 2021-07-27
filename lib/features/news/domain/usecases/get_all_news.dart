import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/core/usecases/no_params.dart';
import 'package:covid_statistics/core/usecases/usecase.dart';
import 'package:covid_statistics/features/news/domain/entities/news.dart';
import 'package:covid_statistics/features/news/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllNews implements UseCase<List<News>, NoParams> {
  final NewsRepository _repository;

  GetAllNews(this._repository);
  @override
  Future<Either<Failure, List<News>>> call(NoParams params) async {
    return await _repository.getAllNews();
  }
}
