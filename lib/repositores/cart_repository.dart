import 'package:fakeapi/models/cart_model.dart';
import 'package:fakeapi/services/cart_service.dart';

class CartRepository {
  final CartService cartService;

  CartRepository({required this.cartService});

  Future<Cart> getCartById(int cartId) async {
    final response = await cartService.getCartById(cartId);
    return Cart.fromJson(response);
  }

  Future<List<Cart>> getUserCarts(int userId) async {
    final response = await cartService.getUserCarts(userId);
    return (response as List).map((cart) => Cart.fromJson(cart)).toList();
  }
}