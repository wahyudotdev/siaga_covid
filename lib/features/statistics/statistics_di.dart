import '../../core/local_storage/local_storage.dart';
import '../../core/query_helper/date_param_helper.dart';
import '../../injection_container.dart';

import 'data/datasources/covid_statistics_local_datasource.dart';
import 'data/datasources/covid_statistics_remote_datasource.dart';
import 'data/repositories/covid_statistics_repository_impl.dart';
import 'domain/repositories/covid_statistics_repository.dart';
import 'domain/usecases/get_covid_statistics_of_week.dart';
import 'presentation/bloc/covid_statistics_bloc.dart';

void statisticsDi() {
  /// Core
  sl.registerLazySingleton<GetDateParam>(() => GetDateParam());
  sl.registerLazySingleton<LocalStorage>(
    () => LocalStorageImpl(boxName: STATISTICS_BOX_NAME),
    instanceName: STATISTICS_BOX_NAME,
  );

  /// BloC
  sl.registerFactory(() => CovidStatisticsBloc(
        covidStatisticsOfWeek: sl(),
        getDateParam: sl(),
      ));

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
}
