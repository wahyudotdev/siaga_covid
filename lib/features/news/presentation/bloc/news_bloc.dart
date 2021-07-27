import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/core/usecases/no_params.dart';
import 'package:covid_statistics/features/news/domain/entities/news.dart';
import 'package:covid_statistics/features/news/domain/usecases/get_all_news.dart';
import 'package:covid_statistics/features/news/domain/usecases/get_favorite_news.dart';
import 'package:covid_statistics/features/news/domain/usecases/save_or_delete_favorite_news.dart';
import 'package:equatable/equatable.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetAllNews getAllNews;
  final GetFavoriteNews getFavoriteNews;
  final SaveOrDeleteFavoriteNews saveOrDeleteFavoriteNews;
  NewsBloc({
    required this.getAllNews,
    required this.getFavoriteNews,
    required this.saveOrDeleteFavoriteNews,
  }) : super(NewsInitial());

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is GetAllNewsEvent) {
      yield LoadingNews();
      final result = await getAllNews(NoParams());
      yield* result.fold(
        (failure) async* {
          yield ErrorLoadingNews(message: CacheFailure.MESSAGE);
        },
        (news) async* {
          yield LoadedAllNews(news: news);
        },
      );
    }
    if (event is GetFavoriteNewsEvent) {
      yield LoadingNews();
      final result = await getFavoriteNews(NoParams());
      yield* result.fold((l) async* {
        yield ErrorLoadingNews(message: CacheFailure.MESSAGE);
      }, (news) async* {
        yield LoadedFavoriteNews(news: news);
      });
    }
    if (event is SaveOrDeleteFavoriteNewsEvent) {
      yield LoadingNews();
      final result =
          await saveOrDeleteFavoriteNews(NewsParams(news: event.news));
      yield* result.fold((l) async* {
        yield ErrorLoadingNews(message: CacheFailure.MESSAGE);
      }, (news) async* {
        yield FavoriteNews(news: news);
      });
    }
  }
}
