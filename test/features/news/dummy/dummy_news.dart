import 'dart:convert';

import 'package:covid_statistics/features/news/data/models/news_model.dart';
import 'package:covid_statistics/features/news/domain/entities/news.dart';
import 'package:webfeed/domain/rss_enclosure.dart';
import 'package:webfeed/domain/rss_item.dart';

import '../../../fixtures/fixture_reader.dart';

Map<String, dynamic> dummyNewsJson = json.decode(fixture('dummy_news.json'));
RssItem rssItem = RssItem(
  title: dummyNewsJson['title'],
  description: dummyNewsJson['description'],
  link: dummyNewsJson['link'],
  enclosure: RssEnclosure(dummyNewsJson['imageUrl'], 'image/jpeg', 1000),
  pubDate: dummyNewsJson['pubDate'],
);

final tNews = News(
  title: dummyNewsJson['title'],
  description: dummyNewsJson['description'],
  pubDate: dummyNewsJson['pubDate'],
  imageUrl: dummyNewsJson['imageUrl'],
  minuteReading: '0',
  link: dummyNewsJson['link'],
  base64Image: dummyNewsJson['base64Image'],
  isFavorite: dummyNewsJson['isFavorite'],
);

final tNewsJsonString = NewsModel.fromEntity(news: tNews).toJsonString();

final tNewsFavoriteString =
    NewsModel.fromEntity(news: tNews, isFavorite: true).toJsonString();
