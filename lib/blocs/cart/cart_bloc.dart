import 'package:fakeapi/blocs/cart/cart_event.dart';
import 'package:fakeapi/blocs/cart/cart_state.dart';
import 'package:fakeapi/repositores/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());

    try {
      final cart = await cartRepository.getCartById(event.cartId);
      emit(CartLoaded(cart: cart));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}