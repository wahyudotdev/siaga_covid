import 'package:dio/dio.dart';
import 'package:webfeed/domain/rss_feed.dart';

class RssNews {
  Future<RssFeed> getNews() async {
    try {
      final result = await Dio().get('https://covid19.go.id/feed/berita');
      return RssFeed.parse(result.data);
    } catch (e) {
      return Future.error(e);
    }
  }
}
