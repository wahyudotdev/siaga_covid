import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/features/news/data/models/news_model.dart';
import 'package:covid_statistics/features/news/domain/usecases/save_or_delete_favorite_news.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/dummy_news.dart';
import 'get_all_news_test.mocks.dart';

void main() {
  final repository = MockNewsRepository();
  final usecase = SaveOrDeleteFavoriteNews(repository);
  test(
    'should return News with isFavorite == true when provided with News with isFavorite==false',
    () async {
      final tNewsFavorite = NewsModel.fromEntity(news: tNews, isFavorite: true);
      // arrange
      when(repository.addOrDeleteFavoriteNews(any))
          .thenAnswer((realInvocation) async => Right(tNewsFavorite));
      // act
      final result = await usecase(NewsParams(news: tNews));
      // assert
      verify(repository.addOrDeleteFavoriteNews(tNews));
      expect(result, Right(tNewsFavorite));
    },
  );

  test(
    'should return News with isFavorite == false when provided with News with isFavorite==true',
    () async {
      // arrange
      final tNewsFavorite = NewsModel.fromEntity(news: tNews, isFavorite: true);
      when(repository.addOrDeleteFavoriteNews(any))
          .thenAnswer((realInvocation) async => Right(tNewsFavorite));
      // act
      final result = await usecase(NewsParams(news: tNews));
      // assert
      verify(repository.addOrDeleteFavoriteNews(tNews));
      expect(result, Right(tNewsFavorite));
    },
  );

  test(
    'should return a [CacheFailure] when there is an error',
    () async {
      // arrange
      when(repository.addOrDeleteFavoriteNews(any))
          .thenAnswer((realInvocation) async => Left(CacheFailure()));
      // act
      final result = await usecase(NewsParams(news: tNews));
      // assert
      verify(repository.addOrDeleteFavoriteNews(tNews));
      expect(result, Left(CacheFailure()));
    },
  );
}
