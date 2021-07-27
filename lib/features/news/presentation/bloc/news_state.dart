part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class LoadingNews extends NewsState {}

class LoadedNews extends NewsState {
  final List<News> news;

  LoadedNews({required this.news});
}

class LoadedFavoriteNews extends NewsState {
  final List<News> news;

  LoadedFavoriteNews({required this.news});
}

class FavoriteNews extends NewsState {
  final News news;

  FavoriteNews(this.news);
}
