import 'package:covid_statistics/core/error/exception.dart';
import 'package:covid_statistics/core/local_storage/local_storage.dart';
import 'package:covid_statistics/features/news/data/datasource/news_local_datasource.dart';
import 'package:covid_statistics/features/news/data/models/news_model.dart';
import 'package:covid_statistics/features/news/domain/entities/news.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../statistics/data/datasources/covid_statistics_local_datasource_test.mocks.dart';
import '../../dummy/dummy_news.dart';

@GenerateMocks([LocalStorage])
void main() {
  final localStorage = MockLocalStorage();
  final dataSource = NewsLocalDataSourceImpl(localStorage);

  group('[cacheNews]', () {
    test(
      'should call localStorage [saveData] method to cache when article link as key and news as value are provided',
      () async {
        // arrange
        when(localStorage.saveData())
            .thenAnswer((realInvocation) async => null);
        // act
        await dataSource.cacheNews(news: tNews);
        // assert
        verify(localStorage.saveData(key: tNews.link, value: tNewsJsonString));
      },
    );

    test(
      'should throw [CacheException] when there is an error while saving the data',
      () async {
        // arrange
        when(localStorage.saveData(key: tNews.link!, value: tNewsJsonString))
            .thenThrow(Exception());
        // act
        final call = dataSource.cacheNews;
        // assert
        expect(() => call(news: tNews), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('[getAllNews]', () {
    test(
      'should return all available news from storage',
      () async {
        final dummyLen = 2;
        final stringList = List<String>.filled(dummyLen, tNewsJsonString);
        // arrange
        when(localStorage.getAllData())
            .thenAnswer((realInvocation) async => stringList);
        // act
        final result = await dataSource.getAllNews();
        // assert
        final expected = List<News>.filled(dummyLen, tNews);
        verify(localStorage.getAllData());
        expect(result, equals(expected));
      },
    );

    test(
      'should throw [CacheException] when there is an error while saving the data',
      () async {
        // arrange
        when(localStorage.getAllData()).thenThrow(Exception());
        // act
        final call = dataSource.getAllNews;
        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('[saveFavoriteNews]', () {
    test(
      'should call a saveData method with isFavourite==true then returning [News] with isFavorite==true when provided with url as key',
      () async {
        // arrange
        when(localStorage.saveData(
                key: tNews.link!, value: tNewsFavoriteString))
            .thenAnswer((realInvocation) async => null);
        // act
        final result = await dataSource.saveFavoriteNews(news: tNews);
        // assert
        verify(
            localStorage.saveData(key: tNews.link, value: tNewsFavoriteString));
        expect(result,
            equals(NewsModel.fromJsonString(tNewsFavoriteString).toEntity()));
      },
    );

    test(
      'should throw [CacheException] when there is an error while saving the data',
      () async {
        // arrange
        when(localStorage.saveData(
                key: tNews.link!, value: tNewsFavoriteString))
            .thenThrow(Exception());
        // act
        final call = dataSource.saveFavoriteNews;
        // assert
        expect(() => call(news: tNews), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('[deleteFavoriteNews]', () {
    test(
      'should set isFavorite to false on corresponding [News] object inside local storage when method is called',
      () async {
        // arrange
        when(localStorage.saveData(key: tNews.link, value: tNewsJsonString))
            .thenAnswer((realInvocation) async => null);
        // act
        final result = await dataSource.deleteFavoriteNews(news: tNews);
        // assert
        verify(localStorage.saveData(key: tNews.link, value: tNewsJsonString));
        expect(result, NewsModel.fromJsonString(tNewsJsonString).toEntity());
      },
    );

    test(
      'should throw [CacheException] when localstorage throw any Exception',
      () async {
        // arrange
        when(localStorage.saveData(key: tNews.link, value: tNewsJsonString))
            .thenThrow(Exception());
        // act
        final call = dataSource.deleteFavoriteNews;
        // assert
        expect(() => call(news: tNews), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });
}
