import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/core/usecases/no_params.dart';
import 'package:covid_statistics/features/news/domain/repositories/news_repository.dart';
import 'package:covid_statistics/features/news/domain/usecases/get_all_news.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/dummy_news.dart';
import 'get_all_news_test.mocks.dart';

@GenerateMocks([NewsRepository])
void main() {
  final repository = MockNewsRepository();
  final usecase = GetAllNews(repository);
  test(
    'should return list of news when there is successfull request',
    () async {
      // arrange
      when(repository.getAllNews())
          .thenAnswer((realInvocation) async => Right([tNews]));
      // act
      final result = await usecase(NoParams());
      // assert
      verify(repository.getAllNews());
      expect(listEquals(result.toIterable().single, [tNews]), true);
    },
  );

  test(
    'should return a [CacheFailure] when there is CacheFailure from repository',
    () async {
      // arrange
      when(repository.getAllNews())
          .thenAnswer((realInvocation) async => Left(CacheFailure()));
      // act
      final result = await usecase(NoParams());
      // assert
      verify(repository.getAllNews());
      expect(result, equals(Left(CacheFailure())));
    },
  );
}
