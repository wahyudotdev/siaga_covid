import 'dart:convert';
import 'dart:io';

import 'package:covid_statistics/core/error/exception.dart';
import 'package:covid_statistics/features/news/data/models/news_model.dart';
import 'package:covid_statistics/features/news/domain/entities/news.dart';
import 'package:http/http.dart';
import 'package:webfeed/domain/rss_feed.dart';

abstract class NewsRemoteDataSource {
  /// Throw [ServerException] when fail to get data from remote
  Future<List<News>> getNews();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  static const NEWS_API_URL = 'https://covid19.go.id/feed/berita';
  final Client client;

  Future<String> networkImageToBase64(String imageUrl) async {
    Response response = await client.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return base64Encode(bytes);
  }

  NewsRemoteDataSourceImpl(this.client);
  @override
  Future<List<News>> getNews() async {
    final result = await client.get(Uri.parse(NEWS_API_URL));
    if (result.statusCode == HttpStatus.ok) {
      RssFeed feed = RssFeed.parse(result.body);
      List<News> newsList = [];
      for (var rssItem in feed.items!) {
        final base64Image = await networkImageToBase64(rssItem.enclosure!.url!);
        newsList.add(
            NewsModel.fromRssItem(rssItem: rssItem, base64Image: base64Image)
                .toEntity());
      }
      return newsList;
    } else {
      throw ServerException();
    }
  }
}
