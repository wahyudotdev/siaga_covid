import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/features/news/domain/entities/news.dart';
import 'package:dartz/dartz.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<News>>> getNews();
}
