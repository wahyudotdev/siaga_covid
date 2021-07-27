import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/core/usecases/no_params.dart';
import 'package:covid_statistics/features/news/domain/usecases/get_favorite_news.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/dummy_news.dart';
import 'get_all_news_test.mocks.dart';

void main() {
  final repository = MockNewsRepository();
  final usecase = GetFavoriteNews(repository);
  test(
    'should return a list of favorite news whenever from repository',
    () async {
      // arrange
      when(repository.getFavoriteNews())
          .thenAnswer((realInvocation) async => Right([tNews]));
      // act
      final result = await usecase(NoParams());
      // assert
      verify(repository.getFavoriteNews());
      expect(listEquals(result.toIterable().single, [tNews]), true);
    },
  );

  test(
    'should return a [CacheFailure] when no data inside local storage',
    () async {
      // arrange
      when(repository.getFavoriteNews())
          .thenAnswer((realInvocation) async => Left(CacheFailure()));
      // act
      final result = await usecase(NoParams());
      // assert
      verify(repository.getFavoriteNews());
      expect(result, equals(Left(CacheFailure())));
    },
  );
}
