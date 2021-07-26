import 'package:covid_statistics/core/error/exception.dart';
import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/core/network/network_info.dart';
import 'package:covid_statistics/features/news/data/datasource/news_local_datasource.dart';
import 'package:covid_statistics/features/news/data/datasource/news_remote_datasource.dart';
import 'package:covid_statistics/features/news/data/models/news_model.dart';
import 'package:covid_statistics/features/news/data/repositories/news_repository_impl.dart';
import 'package:covid_statistics/features/news/domain/entities/news.dart';
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
      test(
        'should return a List<News> from remote data source when online',
        () async {
          // arrange
          when(networkInfo.isConnected).thenAnswer((_) async => true);
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
          when(networkInfo.isConnected).thenAnswer((_) async => true);
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
          when(networkInfo.isConnected).thenAnswer((_) async => true);
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
          when(networkInfo.isConnected).thenAnswer((_) async => true);
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
      test(
        'should return data from cache when available',
        () async {
          // arrange
          when(networkInfo.isConnected)
              .thenAnswer((realInvocation) async => false);
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
          when(networkInfo.isConnected)
              .thenAnswer((realInvocation) async => false);
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

  group('[addOrDeleteFavoriteNews]', () {
    final tNewsFavorite =
        NewsModel.fromJsonString(tNewsFavoriteString).toEntity();
    test(
      'should add movie to local storage with isFavorite set to true and return the result',
      () async {
        // arrange
        when(localDataSource.saveFavoriteNews(news: tNews))
            .thenAnswer((_) async => tNewsFavorite);
        when(localDataSource.getAllNews())
            .thenAnswer((realInvocation) async => [tNews]);
        // act
        final result = await repository.addOrDeleteFavoriteNews(tNews);
        // assert
        verify(localDataSource.saveFavoriteNews(news: tNews));
        verifyNever(localDataSource.getAllNews());
        Either<Failure, News> expected = Right(tNewsFavorite);
        expect(result, equals(expected));
      },
    );

    test(
      'should add movie to local storage with isFavorite set to false and return the result',
      () async {
        // arrange
        when(localDataSource.deleteFavoriteNews(news: tNewsFavorite))
            .thenAnswer((_) async => tNews);
        // act
        final result = await repository.addOrDeleteFavoriteNews(tNewsFavorite);
        // assert
        verify(localDataSource.deleteFavoriteNews(news: tNewsFavorite));
        Either<Failure, News> expected = Right(tNews);
        expect(result, equals(expected));
      },
    );
  });

  group('[addOrDeleteFavoriteNews]', () {
    test(
      'should get a List<News> with isFavorite==true from local storage',
      () async {
        final tNewsFavorite =
            NewsModel.fromEntity(news: tNews, isFavorite: true).toEntity();
        final data = [tNews, tNewsFavorite];
        // arrange
        when(localDataSource.getAllNews())
            .thenAnswer((realInvocation) async => data);
        // act
        final result = await repository.getFavoriteNews();
        // assert
        expect(listEquals(result.toIterable().single, [tNewsFavorite]), true);
      },
    );

    test(
      'should return a [CacheFailure] when catch a [CacheException]',
      () async {
        // arrange
        when(localDataSource.getAllNews()).thenThrow(CacheException());
        // act
        final result = await repository.getAllNews();
        // assert
        expect(result, equals(Left(CacheFailure())));
      },
    );
  });
}
