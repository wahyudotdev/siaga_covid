import '../../core/local_storage/local_storage.dart';
import '../../injection_container.dart';

import 'data/datasource/news_local_datasource.dart';
import 'data/datasource/news_remote_datasource.dart';
import 'data/repositories/news_repository_impl.dart';
import 'domain/repositories/news_repository.dart';
import 'domain/usecases/news_usecases.dart';
import 'presentation/bloc/news_bloc.dart';

void newsDi() {
  /// Core
  sl.registerLazySingleton<LocalStorage>(
      () => LocalStorageImpl(boxName: NEWS_BOX_NAME),
      instanceName: NEWS_BOX_NAME);

  /// Bloc
  sl.registerFactory(() => NewsBloc(
        getAllNews: sl(),
        getFavoriteNews: sl(),
        saveOrDeleteFavoriteNews: sl(),
      ));

  /// Datasource
  sl.registerLazySingleton<NewsLocalDataSource>(
      () => NewsLocalDataSourceImpl(sl(instanceName: NEWS_BOX_NAME)));
  sl.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(sl()));

  /// Repository
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      networkInfo: sl(),
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  /// Usecase
  sl.registerLazySingleton<GetAllNews>(() => GetAllNews(sl()));
  sl.registerLazySingleton<GetFavoriteNews>(() => GetFavoriteNews(sl()));
  sl.registerLazySingleton<SaveOrDeleteFavoriteNews>(
      () => SaveOrDeleteFavoriteNews(sl()));
}
