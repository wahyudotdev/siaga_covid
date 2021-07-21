// Mocks generated by Mockito 5.0.11 from annotations
// in covid_statistics/test/core/network/network_info_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:data_connection_checker/data_connection_checker.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeDuration extends _i1.Fake implements Duration {
  @override
  String toString() => super.toString();
}

class _FakeAddressCheckResult extends _i1.Fake
    implements _i2.AddressCheckResult {
  @override
  String toString() => super.toString();
}

/// A class which mocks [DataConnectionChecker].
///
/// See the documentation for Mockito's code generation for more information.
class MockDataConnectionChecker extends _i1.Mock
    implements _i2.DataConnectionChecker {
  MockDataConnectionChecker() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i2.AddressCheckOptions> get addresses =>
      (super.noSuchMethod(Invocation.getter(#addresses),
              returnValue: <_i2.AddressCheckOptions>[])
          as List<_i2.AddressCheckOptions>);
  @override
  set addresses(List<_i2.AddressCheckOptions>? _addresses) =>
      super.noSuchMethod(Invocation.setter(#addresses, _addresses),
          returnValueForMissingStub: null);
  @override
  Duration get checkInterval =>
      (super.noSuchMethod(Invocation.getter(#checkInterval),
          returnValue: _FakeDuration()) as Duration);
  @override
  set checkInterval(Duration? _checkInterval) =>
      super.noSuchMethod(Invocation.setter(#checkInterval, _checkInterval),
          returnValueForMissingStub: null);
  @override
  List<_i2.AddressCheckResult> get lastTryResults => (super.noSuchMethod(
      Invocation.getter(#lastTryResults),
      returnValue: <_i2.AddressCheckResult>[]) as List<_i2.AddressCheckResult>);
  @override
  _i3.Future<bool> get hasConnection =>
      (super.noSuchMethod(Invocation.getter(#hasConnection),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  _i3.Future<_i2.DataConnectionStatus> get connectionStatus =>
      (super.noSuchMethod(Invocation.getter(#connectionStatus),
              returnValue: Future<_i2.DataConnectionStatus>.value(
                  _i2.DataConnectionStatus.disconnected))
          as _i3.Future<_i2.DataConnectionStatus>);
  @override
  _i3.Stream<_i2.DataConnectionStatus> get onStatusChange =>
      (super.noSuchMethod(Invocation.getter(#onStatusChange),
              returnValue: Stream<_i2.DataConnectionStatus>.empty())
          as _i3.Stream<_i2.DataConnectionStatus>);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  bool get isActivelyChecking =>
      (super.noSuchMethod(Invocation.getter(#isActivelyChecking),
          returnValue: false) as bool);
  @override
  _i3.Future<_i2.AddressCheckResult> isHostReachable(
          _i2.AddressCheckOptions? options) =>
      (super.noSuchMethod(Invocation.method(#isHostReachable, [options]),
              returnValue: Future<_i2.AddressCheckResult>.value(
                  _FakeAddressCheckResult()))
          as _i3.Future<_i2.AddressCheckResult>);
}
