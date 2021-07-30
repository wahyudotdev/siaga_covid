import 'features/news/news_di.dart';
import 'features/statistics/statistics_di.dart';

import 'core/network/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final sl = GetIt.instance;
void init() {
  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External
  sl.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());
  sl.registerLazySingleton<Client>(() => Client());

  statisticsDi();
  newsDi();
}
