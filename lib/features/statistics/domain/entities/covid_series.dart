import 'package:equatable/equatable.dart';

class CovidSeries extends Equatable {
  final String date;
  final int confirmed;

  CovidSeries({required this.date, required this.confirmed});

  @override
  List<Object?> get props => [date, confirmed];
}
