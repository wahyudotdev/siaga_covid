import 'package:covid_statistics/core/network/network_info.dart';
import 'package:covid_statistics/core/query_helper/date_param_helper.dart';
import 'package:covid_statistics/core/utils/short_list.dart';
import 'package:covid_statistics/features/statistics/data/datasources/covid_statistics_remote_datasource.dart';
import 'package:covid_statistics/features/statistics/data/repositories/covid_statistics_repository_impl.dart';
import 'package:covid_statistics/features/statistics/domain/repositories/covid_statistics_repository.dart';
import 'package:covid_statistics/features/statistics/domain/usecases/get_covid_statistics_of_week.dart';
import 'package:covid_statistics/features/statistics/presentation/bloc/covid_statistics_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final sl = GetIt.instance;
void init() {
  /// Util
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<GetDateParam>(() => GetDateParam());
  sl.registerLazySingleton<ShortList>(() => ShortList());

  /// Datasource
  sl.registerLazySingleton<CovidStatisticsRemoteDataSource>(
    () => CovidStatisticsRemoteDataSourceImpl(sl()),
  );

  /// Repository
  sl.registerLazySingleton<CovidStatisticsRepository>(
      () => CovidStatisticsRepositoryImpl(
            remoteDataSource: sl(),
            networkInfo: sl(),
            shortList: sl(),
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
  sl.registerFactory(() => DataConnectionChecker());
  sl.registerFactory(() => Client());
}
