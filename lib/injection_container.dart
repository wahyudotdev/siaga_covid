import 'package:covid_statistics/core/local_storage/local_storage.dart';
import 'package:covid_statistics/features/statistics/data/datasources/covid_statistics_local_datasource.dart';

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
  /// Util
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<GetDateParam>(() => GetDateParam());
  sl.registerLazySingleton<LocalStorage>(
    () => LocalStorageImpl(boxName: STATISTICS_BOX_NAME),
    instanceName: STATISTICS_BOX_NAME,
  );

  /// Datasource
  sl.registerLazySingleton<CovidStatisticsRemoteDataSource>(
      () => CovidStatisticsRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<CovidStatisticsLocalDataSource>(
      () => CovidStatisticsLocalDataSourceImpl(sl(
            instanceName: STATISTICS_BOX_NAME,
          )));

  /// Repository
  sl.registerLazySingleton<CovidStatisticsRepository>(
      () => CovidStatisticsRepositoryImpl(
            remoteDataSource: sl(),
            localDataSource: sl(),
            networkInfo: sl(),
          ));

  /// Usecase
  sl.registerLazySingleton<GetCovidStatisticsOfWeek>(
      () => GetCovidStatisticsOfWeek(sl()));

  /// BloC
  sl.registerFactory(() => CovidStatisticsBloc(
        covidStatisticsOfWeek: sl(),
        getDateParam: sl(),
      ));

  /// External
  sl.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());
  sl.registerLazySingleton<Client>(() => Client());
}
