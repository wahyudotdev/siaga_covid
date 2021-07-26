import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? link;
  final String? pubDate;
  final String? minuteReading;
  final bool? isFavorite;
  final String? base64Image;

  News({
    this.title,
    this.description,
    this.imageUrl,
    this.link,
    this.pubDate,
    this.minuteReading,
    this.isFavorite,
    this.base64Image,
  });

  @override
  List<Object?> get props => [
        title,
        imageUrl,
        link,
        pubDate,
        base64Image,
        isFavorite,
      ];
}
