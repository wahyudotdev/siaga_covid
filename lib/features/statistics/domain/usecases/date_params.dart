import 'package:equatable/equatable.dart';

class DateParams extends Equatable {
  final List<String> daysOfWeek;

  DateParams({required this.daysOfWeek});
  @override
  List<Object?> get props => [daysOfWeek];
}
