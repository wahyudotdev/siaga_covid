import 'package:covid_statistics/core/error/exception.dart';
import 'package:covid_statistics/core/network/network_info.dart';
import 'package:covid_statistics/features/news/data/datasource/news_local_datasource.dart';
import 'package:covid_statistics/features/news/data/datasource/news_remote_datasource.dart';
import 'package:covid_statistics/features/news/domain/entities/news.dart';
import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/features/news/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NetworkInfo networkInfo;
  final NewsLocalDataSource localDataSource;
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<News>>> getAllNews() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getNews();
        for (var item in result) {
          await localDataSource.cacheNews(news: item);
        }
        return Right(result);
      } on ServerException {
        try {
          final result = await localDataSource.getAllNews();
          return Right(result);
        } on CacheException {
          return Left(CacheFailure());
        }
      }
    } else {
      try {
        final result = await localDataSource.getAllNews();
        if (result.isNotEmpty) {
          return Right(result);
        } else {
          return Left(CacheFailure());
        }
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, News>> addOrDeleteFavoriteNews(News news) async {
    if (news.isFavorite!) {
      final result = await localDataSource.deleteFavoriteNews(news: news);
      return Right(result);
    } else {
      final result = await localDataSource.saveFavoriteNews(news: news);
      return Right(result);
    }
  }

  @override
  Future<Either<Failure, List<News>>> getFavoriteNews() async {
    try {
      final result = await localDataSource.getAllNews();
      final favoriteList =
          result.where((value) => value.isFavorite == true).toList();
      if (favoriteList.isNotEmpty) {
        return Right(favoriteList);
      } else
        return Left(CacheFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
