import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}
class FilterProductsByCategory extends HomeEvent {
  final String category;

  const FilterProductsByCategory({required this.category});

  @override
  List<Object> get props => [category];
}

class LoadProducts extends HomeEvent {}
