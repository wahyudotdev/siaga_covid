// Mocks generated by Mockito 5.0.11 from annotations
// in covid_statistics/test/features/news/presentation/bloc/news_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:covid_statistics/core/error/failure.dart' as _i5;
import 'package:covid_statistics/core/usecases/no_params.dart' as _i7;
import 'package:covid_statistics/features/news/domain/entities/news.dart'
    as _i6;
import 'package:covid_statistics/features/news/domain/usecases/get_all_news.dart'
    as _i3;
import 'package:covid_statistics/features/news/domain/usecases/get_favorite_news.dart'
    as _i8;
import 'package:covid_statistics/features/news/domain/usecases/save_or_delete_favorite_news.dart'
    as _i9;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetAllNews].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAllNews extends _i1.Mock implements _i3.GetAllNews {
  MockGetAllNews() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.News>>> call(
          _i7.NoParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.News>>>.value(
              _FakeEither<_i5.Failure, List<_i6.News>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.News>>>);
}

/// A class which mocks [GetFavoriteNews].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetFavoriteNews extends _i1.Mock implements _i8.GetFavoriteNews {
  MockGetFavoriteNews() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.News>>> call(
          _i7.NoParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.News>>>.value(
              _FakeEither<_i5.Failure, List<_i6.News>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.News>>>);
}

/// A class which mocks [SaveOrDeleteFavoriteNews].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveOrDeleteFavoriteNews extends _i1.Mock
    implements _i9.SaveOrDeleteFavoriteNews {
  MockSaveOrDeleteFavoriteNews() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.News>> call(_i9.NewsParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.News>>.value(
                  _FakeEither<_i5.Failure, _i6.News>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.News>>);
}
