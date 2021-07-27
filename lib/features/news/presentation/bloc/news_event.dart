part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class GetAllNewsEvent extends NewsEvent {}

class GetFavoriteNewsEvent extends NewsEvent {}

class SaveOrDeleteFavoriteNewsEvent extends NewsEvent {
  final News news;

  SaveOrDeleteFavoriteNewsEvent({required this.news});
}
