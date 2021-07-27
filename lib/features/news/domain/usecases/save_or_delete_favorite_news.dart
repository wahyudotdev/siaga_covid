import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/core/usecases/usecase.dart';
import 'package:covid_statistics/features/news/domain/entities/news.dart';
import 'package:covid_statistics/features/news/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SaveOrDeleteFavoriteNews implements UseCase<News, NewsParams> {
  final NewsRepository _repository;

  SaveOrDeleteFavoriteNews(this._repository);
  @override
  Future<Either<Failure, News>> call(NewsParams params) async {
    return await _repository.addOrDeleteFavoriteNews(params.news);
  }
}

class NewsParams extends Equatable {
  final News news;

  NewsParams({required this.news});

  @override
  List<Object?> get props => [news];
}
