import 'package:covid_statistics/features/news/data/models/news_model.dart';
import 'package:covid_statistics/features/news/domain/entities/news.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../dummy/dummy_image_data.dart';
import '../../dummy/dummy_news.dart';

void main() {
  final tNewsModel = NewsModel(
    title: dummyNewsJson['title'],
    description: dummyNewsJson['description'],
    pubDate: dummyNewsJson['pubDate'],
    imageUrl: dummyNewsJson['imageUrl'],
    minuteReading: '0',
    link: dummyNewsJson['link'],
    isFavorite: false,
    base64Image: imageString,
  );

  test('[NewsModel] must be a subclass of [News]',
      () => expect(tNewsModel, isA<News>()));

  test(
    'should return a [NewsModel] when there is RssItem provided',
    () async {
      // act
      final result = NewsModel.fromRssItem(
        rssItem: rssItem,
        base64Image: imageString,
      );
      // assert
      expect(result, equals(tNewsModel));
    },
  );

  test(
    'should return a [NewsModel] from json string',
    () async {
      // arrange
      final jsonString = fixture('dummy_news.json');
      // act
      final result = NewsModel.fromJsonString(jsonString);
      // assert
      expect(result, equals(tNewsModel));
    },
  );
}
