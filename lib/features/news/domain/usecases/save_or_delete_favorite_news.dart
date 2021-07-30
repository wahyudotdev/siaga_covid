import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/news.dart';
import '../repositories/news_repository.dart';
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
