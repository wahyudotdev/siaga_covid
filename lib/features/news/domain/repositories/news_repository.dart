import '../../../../core/error/failure.dart';
import '../entities/news.dart';
import 'package:dartz/dartz.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<News>>> getAllNews();
  Future<Either<Failure, List<News>>> getFavoriteNews();
  Future<Either<Failure, News>> addOrDeleteFavoriteNews(News news);
}
