// Mocks generated by Mockito 5.0.11 from annotations
// in covid_statistics/test/features/statistics/bloc/covid_statistics_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:covid_statistics/core/error/failure.dart' as _i6;
import 'package:covid_statistics/core/query_helper/date_param_helper.dart'
    as _i8;
import 'package:covid_statistics/core/utils/short_list.dart' as _i9;
import 'package:covid_statistics/features/statistics/domain/entities/covid_statistics.dart'
    as _i7;
import 'package:covid_statistics/features/statistics/domain/repositories/covid_statistics_repository.dart'
    as _i2;
import 'package:covid_statistics/features/statistics/domain/usecases/get_covid_statistics_of_week.dart'
    as _i4;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeCovidStatisticsRepository extends _i1.Fake
    implements _i2.CovidStatisticsRepository {}

class _FakeEither<L, R> extends _i1.Fake implements _i3.Either<L, R> {
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetCovidStatisticsOfWeek].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetCovidStatisticsOfWeek extends _i1.Mock
    implements _i4.GetCovidStatisticsOfWeek {
  MockGetCovidStatisticsOfWeek() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.CovidStatisticsRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
              returnValue: _FakeCovidStatisticsRepository())
          as _i2.CovidStatisticsRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.CovidStatistics>>> call(
          _i4.DateParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
          returnValue:
              Future<_i3.Either<_i6.Failure, List<_i7.CovidStatistics>>>.value(
                  _FakeEither<_i6.Failure, List<_i7.CovidStatistics>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.CovidStatistics>>>);
}

/// A class which mocks [GetDateParam].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetDateParam extends _i1.Mock implements _i8.GetDateParam {
  MockGetDateParam() {
    _i1.throwOnMissingStub(this);
  }
}

/// A class which mocks [ShortList].
///
/// See the documentation for Mockito's code generation for more information.
class MockShortList extends _i1.Mock implements _i9.ShortList {
  MockShortList() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i7.CovidStatistics> shortByDate(List<_i7.CovidStatistics>? list) =>
      (super.noSuchMethod(Invocation.method(#shortByDate, [list]),
          returnValue: <_i7.CovidStatistics>[]) as List<_i7.CovidStatistics>);
}
