import 'package:covid_statistics/core/local_storage/local_storage.dart';
import 'package:covid_statistics/features/news/news_di.dart';
import 'package:covid_statistics/features/news/presentation/bloc/news_bloc.dart';
import 'package:covid_statistics/features/statistics/data/datasources/covid_statistics_local_datasource.dart';
import 'package:covid_statistics/features/statistics/statistics_di.dart';

import 'core/network/network_info.dart';
import 'core/query_helper/date_param_helper.dart';
import 'features/statistics/data/datasources/covid_statistics_remote_datasource.dart';
import 'features/statistics/data/repositories/covid_statistics_repository_impl.dart';
import 'features/statistics/domain/repositories/covid_statistics_repository.dart';
import 'features/statistics/domain/usecases/get_covid_statistics_of_week.dart';
import 'features/statistics/presentation/bloc/covid_statistics_bloc.dart';
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
