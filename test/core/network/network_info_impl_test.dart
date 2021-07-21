import 'package:covid_statistics/core/network/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_impl_test.mocks.dart';

@GenerateMocks([DataConnectionChecker])
void main() {
  late MockDataConnectionChecker dataConnectionChecker;
  late NetworkInfoImpl networkInfoImpl;
  setUp(() {
    dataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(dataConnectionChecker);
  });

  group('isConnected', () {
    test('should forward call to data DataConnectionChecker.hasConnection',
        () async {
      final tHasConnectionFuture = Future.value(true);
      when(dataConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);

      final result = networkInfoImpl.isConnected;

      verify(dataConnectionChecker.hasConnection);
      expect(result, tHasConnectionFuture);
    });
  });
}
