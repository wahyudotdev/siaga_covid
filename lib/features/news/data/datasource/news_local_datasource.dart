import 'package:covid_statistics/core/error/exception.dart';
import 'package:covid_statistics/core/local_storage/local_storage.dart';
import 'package:covid_statistics/features/news/data/models/news_model.dart';
import 'package:covid_statistics/features/news/domain/entities/news.dart';

abstract class NewsLocalDataSource {
  Future<List<News>> getAllNews();
  Future<void> cacheNews({required News news});
  Future<News> saveFavoriteNews({required News news});
  Future<News> deleteFavoriteNews({required News news});
}

const NEWS_BOX_NAME = 'covid_news';

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final LocalStorage _localStorage;

  NewsLocalDataSourceImpl(this._localStorage);
  @override
  Future<void> cacheNews({required News news}) async {
    try {
      final jsonString = NewsModel.fromEntity(news: news).toJsonString();
      await _localStorage.saveData(key: news.link!, value: jsonString);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<News>> getAllNews() async {
    try {
      final stringList = await _localStorage.getAllData();
      return stringList
          .map((e) => NewsModel.fromJsonString(e).toEntity())
          .toList();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<News> saveFavoriteNews({required News news}) async {
    try {
      final jsonString =
          NewsModel.fromEntity(news: news, isFavorite: true).toJsonString();
      await _localStorage.saveData(key: news.link!, value: jsonString);
      return NewsModel.fromJsonString(jsonString).toEntity();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<News> deleteFavoriteNews({required News news}) async {
    try {
      final jsonString =
          NewsModel.fromEntity(news: news, isFavorite: false).toJsonString();
      await _localStorage.saveData(key: news.link!, value: jsonString);
      return NewsModel.fromJsonString(jsonString).toEntity();
    } catch (e) {
      throw CacheException();
    }
  }
}
