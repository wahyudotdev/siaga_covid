import 'dart:convert';
import 'package:covid_statistics/features/news/domain/entities/news.dart';
import 'package:webfeed/domain/rss_item.dart';

class NewsModel extends News {
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? link;
  final String? pubDate;
  final String? minuteReading;
  final bool? isFavorite;
  final String? base64Image;
  static String getWordMinute(String? words) {
    var regExp = RegExp('[^0-9A-Z,\n]', caseSensitive: false, multiLine: true);
    int count = regExp.allMatches(words!).length;
    int readingSpeed = 300;
    return (count / readingSpeed).round().toString();
  }

  NewsModel({
    this.title,
    this.description,
    this.imageUrl,
    this.link,
    this.pubDate,
    this.minuteReading,
    this.isFavorite,
    this.base64Image,
  }) : super(
          title: title,
          description: description,
          imageUrl: imageUrl,
          link: link,
          pubDate: pubDate,
          minuteReading: minuteReading,
          base64Image: base64Image,
          isFavorite: isFavorite,
        );

  factory NewsModel.fromRssItem(
          {required RssItem rssItem, String? base64Image}) =>
      NewsModel(
        title: rssItem.title,
        description: rssItem.description,
        imageUrl: rssItem.enclosure!.url,
        link: rssItem.link,
        pubDate: rssItem.pubDate,
        minuteReading: getWordMinute(rssItem.description),
        base64Image: base64Image,
        isFavorite: false,
      );

  factory NewsModel.fromJsonString(String jsonString) {
    final result = json.decode(jsonString);
    return NewsModel(
      title: result['title'],
      description: result['description'],
      imageUrl: result['imageUrl'],
      link: result['link'],
      pubDate: result['pubDate'],
      minuteReading: result['minuteReading'],
      base64Image: result['base64Image'],
      isFavorite: result['isFavorite'],
    );
  }

  String toJsonString() {
    Map<String, dynamic> jsonString = {
      "title": title,
      "description": description,
      "imageUrl": imageUrl,
      "link": link,
      "pubDate": pubDate,
      "minuteReading": minuteReading,
      "isFavorite": isFavorite ?? false,
      "base64Image": base64Image,
    };
    return json.encode(jsonString);
  }

  factory NewsModel.fromEntity({
    required News news,
    String? title,
    String? description,
    String? imageUrl,
    String? link,
    String? pubDate,
    String? minuteReading,
    bool? isFavorite,
    String? base64Image,
  }) =>
      NewsModel(
        title: title ?? news.title,
        description: description ?? news.description,
        imageUrl: imageUrl ?? news.imageUrl,
        base64Image: base64Image ?? news.base64Image,
        isFavorite: isFavorite ?? news.isFavorite,
        link: link ?? news.link,
        minuteReading: minuteReading ?? news.minuteReading,
        pubDate: pubDate ?? news.pubDate,
      );

  News toEntity() {
    return News(
      title: title,
      link: link,
      minuteReading: minuteReading,
      pubDate: pubDate,
      description: description,
      imageUrl: imageUrl,
      isFavorite: isFavorite,
      base64Image: base64Image,
    );
  }
}
