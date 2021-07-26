import 'dart:io';

import 'package:covid_statistics/core/error/exception.dart';
import 'package:covid_statistics/features/news/data/datasource/news_remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/dummy_image_data.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../dummy/dummy_news.dart';
import 'news_remote_datasource_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  late MockClient client;
  late NewsRemoteDataSourceImpl dataSource;
  setUp(() {
    client = MockClient();
    dataSource = NewsRemoteDataSourceImpl(client);
  });

  test(
    'should return [List<News>] when client returning HttpStatus.ok (200)',
    () async {
      // arrange
      when(client.get(Uri.parse(NewsRemoteDataSourceImpl.NEWS_API_URL)))
          .thenAnswer((realInvocation) async =>
              Response(fixture('dummy_news.xml'), HttpStatus.ok));
      when(client.get(Uri.parse(tNews.imageUrl!))).thenAnswer(
          (realInvocation) async => Response.bytes(imageBytes, HttpStatus.ok));
      // act
      final result = await dataSource.getNews();
      // assert
      verify(client.get(Uri.parse(NewsRemoteDataSourceImpl.NEWS_API_URL)));
      verify(client.get(Uri.parse(tNews.imageUrl!)));
      final expected = [tNews];
      expect(result, equals(expected));
    },
  );

  test(
    'should throw a [ServerException] when there is error when fetching data from RSS Feed',
    () async {
      // arrange
      when(client.get(Uri.parse(NewsRemoteDataSourceImpl.NEWS_API_URL)))
          .thenAnswer((realInvocation) async =>
              Response('Not found error', HttpStatus.notFound));
      // act
      final call = dataSource.getNews;
      // assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    },
  );
}
