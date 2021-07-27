import 'package:covid_statistics/core/error/failure.dart';
import 'package:covid_statistics/features/news/domain/usecases/get_all_news.dart';
import 'package:covid_statistics/features/news/domain/usecases/get_favorite_news.dart';
import 'package:covid_statistics/features/news/domain/usecases/save_or_delete_favorite_news.dart';
import 'package:covid_statistics/features/news/presentation/bloc/news_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy/dummy_news.dart';
import 'news_bloc_test.mocks.dart';

@GenerateMocks([
  GetAllNews,
  GetFavoriteNews,
  SaveOrDeleteFavoriteNews,
])
void main() {
  final getAllNews = MockGetAllNews();
  final getFavoriteNews = MockGetFavoriteNews();
  final saveOrDeleteFavoriteNews = MockSaveOrDeleteFavoriteNews();
  final bloc = NewsBloc(
    getAllNews: getAllNews,
    getFavoriteNews: getFavoriteNews,
    saveOrDeleteFavoriteNews: saveOrDeleteFavoriteNews,
  );

  group('[GetAllNewsEvent]', () {
    test(
      'should emit [LoadingNews, LoadedAllNews] when there is GetAllNewsEvent',
      () async {
        // arrange
        when(getAllNews(any))
            .thenAnswer((realInvocation) async => Right([tNews]));
        // assert later
        final state = [
          LoadingNews(),
          LoadedAllNews(news: [tNews])
        ];
        expectLater(bloc.stream, emitsInOrder(state));
        // act
        bloc.add(GetAllNewsEvent());
        await untilCalled(getAllNews(any));
        verify(getAllNews(any));
      },
    );

    test(
      'should emit [Loading, ErrorLoadingNews] when there is CacheFailure',
      () async {
        // arrange
        when(getAllNews(any))
            .thenAnswer((realInvocation) async => Left(CacheFailure()));
        // assert later
        final state = [
          LoadingNews(),
          ErrorLoadingNews(message: CacheFailure.MESSAGE),
        ];
        expectLater(bloc.stream, emitsInOrder(state));
        // act
        bloc.add(GetAllNewsEvent());
        await untilCalled(getAllNews(any));
      },
    );
  });

  group('[GetFavoriteNewsEvent]', () {
    test(
      'should emit [LoadingNews, LoadedFavoriteNews] when there is GetFavoriteNewsEvent',
      () async {
        // arrange
        when(getFavoriteNews(any))
            .thenAnswer((realInvocation) async => Right([tFavoriteNews]));
        // assert later
        final state = [
          LoadingNews(),
          LoadedFavoriteNews(news: [tFavoriteNews])
        ];
        expectLater(bloc.stream, emitsInOrder(state));
        // act
        bloc.add(GetFavoriteNewsEvent());
        await untilCalled(getFavoriteNews(any));
        verify(getFavoriteNews(any));
      },
    );

    test(
      'should emit [LoadingNews, ErrorLoadingNews] when there is CacheFailure',
      () async {
        // arrange
        when(getFavoriteNews(any))
            .thenAnswer((realInvocation) async => Left(CacheFailure()));
        // assert later
        final state = [
          LoadingNews(),
          ErrorLoadingNews(message: CacheFailure.MESSAGE),
        ];
        expectLater(bloc.stream, emitsInOrder(state));
        // act
        bloc.add(GetFavoriteNewsEvent());
        await untilCalled(getFavoriteNews(any));
      },
    );
  });

  group('[SaveOrDeleteFavoriteNewsEvent]', () {
    test(
      'should emit [LoadingNews, FavoriteNews] when there is SaveOrDeleteFavoriteNewsEvent',
      () async {
        // arrange
        when(saveOrDeleteFavoriteNews(any))
            .thenAnswer((realInvocation) async => Right(tFavoriteNews));

        // assert later
        final state = [
          LoadingNews(),
          FavoriteNews(news: tFavoriteNews),
        ];
        expectLater(bloc.stream, emitsInOrder(state));
        // act
        bloc.add(SaveOrDeleteFavoriteNewsEvent(news: tNews));
        await untilCalled(saveOrDeleteFavoriteNews(any));
        verify(saveOrDeleteFavoriteNews(any));
      },
    );

    test(
      'should emit [LoadingNews, ErrorLoadingNews] when there is CacheFailure',
      () async {
        // arrange
        when(saveOrDeleteFavoriteNews(any))
            .thenAnswer((realInvocation) async => Left(CacheFailure()));
        // assert later
        final state = [
          LoadingNews(),
          ErrorLoadingNews(
            message: CacheFailure.MESSAGE,
          ),
        ];
        expectLater(bloc.stream, emitsInOrder(state));
        // act
        bloc.add(SaveOrDeleteFavoriteNewsEvent(news: tNews));
        await untilCalled(saveOrDeleteFavoriteNews(any));
      },
    );
  });
}
