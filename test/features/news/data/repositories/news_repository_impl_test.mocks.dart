// Mocks generated by Mockito 5.0.11 from annotations
// in covid_statistics/test/features/news/data/repositories/news_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:covid_statistics/core/network/network_info.dart' as _i3;
import 'package:covid_statistics/features/news/data/datasource/news_local_datasource.dart'
    as _i5;
import 'package:covid_statistics/features/news/data/datasource/news_remote_datasource.dart'
    as _i6;
import 'package:covid_statistics/features/news/domain/entities/news.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeNews extends _i1.Fake implements _i2.News {}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i3.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
}

/// A class which mocks [NewsLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockNewsLocalDataSource extends _i1.Mock
    implements _i5.NewsLocalDataSource {
  MockNewsLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.News>> getAllNews() =>
      (super.noSuchMethod(Invocation.method(#getAllNews, []),
              returnValue: Future<List<_i2.News>>.value(<_i2.News>[]))
          as _i4.Future<List<_i2.News>>);
  @override
  _i4.Future<void> cacheNews({_i2.News? news}) =>
      (super.noSuchMethod(Invocation.method(#cacheNews, [], {#news: news}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<_i2.News> saveFavoriteNews({_i2.News? news}) => (super
          .noSuchMethod(Invocation.method(#saveFavoriteNews, [], {#news: news}),
              returnValue: Future<_i2.News>.value(_FakeNews()))
      as _i4.Future<_i2.News>);
  @override
  _i4.Future<_i2.News> deleteFavoriteNews({_i2.News? news}) =>
      (super.noSuchMethod(
              Invocation.method(#deleteFavoriteNews, [], {#news: news}),
              returnValue: Future<_i2.News>.value(_FakeNews()))
          as _i4.Future<_i2.News>);
}

/// A class which mocks [NewsRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockNewsRemoteDataSource extends _i1.Mock
    implements _i6.NewsRemoteDataSource {
  MockNewsRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.News>> getNews() =>
      (super.noSuchMethod(Invocation.method(#getNews, []),
              returnValue: Future<List<_i2.News>>.value(<_i2.News>[]))
          as _i4.Future<List<_i2.News>>);
}