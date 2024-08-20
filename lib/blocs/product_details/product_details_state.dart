import 'package:equatable/equatable.dart';
import 'package:fakeapi/models/product_details_model.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object?> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductDetails productDetails;

  const ProductDetailsLoaded({required this.productDetails});

  @override
  List<Object?> get props => [productDetails];
}

class ProductDetailsError extends ProductDetailsState {
  final String message;

  const ProductDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}