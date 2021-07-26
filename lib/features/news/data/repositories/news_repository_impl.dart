import 'package:covid_statistics/features/news/domain/entities/news.dart';
import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/features/news/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';

class NewsRepositoryImpl implements NewsRepository {
  @override
  Future<Either<Failure, List<News>>> getNews() {
    throw UnimplementedError();
  }
}
