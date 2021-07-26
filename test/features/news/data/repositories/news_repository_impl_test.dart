import 'package:covid_statistics/core/error/exception.dart';
import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/core/network/network_info.dart';
import 'package:covid_statistics/features/news/data/datasource/news_local_datasource.dart';
import 'package:covid_statistics/features/news/data/datasource/news_remote_datasource.dart';
import 'package:covid_statistics/features/news/data/repositories/news_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/dummy_news.dart';
import 'news_repository_impl_test.mocks.dart';

@GenerateMocks([
  NetworkInfo,
  NewsLocalDataSource,
  NewsRemoteDataSource,
])
void main() {
  final networkInfo = MockNetworkInfo();
  final localDataSource = MockNewsLocalDataSource();
  final remoteDataSource = MockNewsRemoteDataSource();
  final repository = NewsRepositoryImpl(
    networkInfo: networkInfo,
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
  );

  group('[getAllNews]', () {
    group('Online test', () {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      test(
        'should return a List<News> from remote data source when online',
        () async {
          // arrange
          when(remoteDataSource.getNews()).thenAnswer((_) async => [tNews]);
          // act
          final result = await repository.getAllNews();
          // assert
          verify(remoteDataSource.getNews());
          expect(listEquals(result.toIterable().single, [tNews]), true);
        },
      );

      test(
        'should cache data in local storage when fetch data is successfull',
        () async {
          // arrange
          when(remoteDataSource.getNews()).thenAnswer((_) async => [tNews]);
          when(localDataSource.cacheNews(news: tNews))
              .thenAnswer((_) async => null);
          // act
          await repository.getAllNews();
          // assert
          verify(remoteDataSource.getNews());
          verify(localDataSource.cacheNews(news: tNews));
        },
      );

      test(
        'should fetch the data from local storage when there is a ServerExeption',
        () async {
          // arrange
          when(remoteDataSource.getNews()).thenThrow(ServerException());
          when(localDataSource.getAllNews()).thenAnswer((_) async => [tNews]);
          // act
          final result = await repository.getAllNews();
          // assert
          verify(localDataSource.getAllNews());
          expect(listEquals(result.toIterable().single, [tNews]), true);
        },
      );

      test(
        'should return Left(CacheFailure) when there is [CacheException]',
        () async {
          // arrange
          when(remoteDataSource.getNews()).thenThrow(ServerException());
          when(localDataSource.getAllNews()).thenThrow(CacheException());
          // act
          final result = await repository.getAllNews();
          // assert
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });

    group('Offline test', () {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);

      test(
        'should return data from cache when available',
        () async {
          // arrange
          when(localDataSource.getAllNews())
              .thenAnswer((realInvocation) async => [tNews]);
          // act
          final result = await repository.getAllNews();
          // assert
          verify(localDataSource.getAllNews());
          expect(listEquals(result.toIterable().single, [tNews]), true);
        },
      );

      test(
        'should return a [CacheFailure] when there is [CacheException]',
        () async {
          // arrange
          when(localDataSource.getAllNews()).thenThrow(CacheException());
          // act
          final result = await repository.getAllNews();
          // assert
          expect(result, equals(Left(CacheFailure())));
        },
      );

      test(
        'should return a [CacheFailure] when there is no data inside local storage',
        () async {
          // arrange
          when(localDataSource.getAllNews())
              .thenAnswer((realInvocation) async => []);
          // act
          final result = await repository.getAllNews();
          // assert
          verify(localDataSource.getAllNews());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
