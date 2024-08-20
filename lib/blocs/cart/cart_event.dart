import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {
  final int cartId;

  const LoadCart({required this.cartId});

  @override
  List<Object?> get props => [cartId];
}