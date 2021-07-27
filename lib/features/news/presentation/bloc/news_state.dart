part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class LoadingNews extends NewsState {}

class LoadedAllNews extends NewsState {
  final List<News> news;

  LoadedAllNews({required this.news});
}

class LoadedFavoriteNews extends NewsState {
  final List<News> news;

  LoadedFavoriteNews({required this.news});
}

class FavoriteNews extends NewsState {
  final News news;

  FavoriteNews({required this.news});
}

class ErrorLoadingNews extends NewsState {
  final String message;

  ErrorLoadingNews({required this.message});
}
