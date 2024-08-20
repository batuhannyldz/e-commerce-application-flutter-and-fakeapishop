// cart_service/cart_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class CartService {
  final String baseUrl = 'https://fakestoreapi.com/carts';

  Future<Map<String, dynamic>> getCartById(int cartId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$cartId'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load cart');
      }
    } catch (e) {
      throw Exception('Error fetching cart: $e');
    }
  }
Future<Map<String, dynamic>> getProductDetails(int productId) async {
  try {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/$productId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product details');
    }
  } catch (e) {
    throw Exception('Error fetching product details: $e');
  }
}
  Future<List<dynamic>> getUserCarts(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/user/$userId'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load user carts');
      }
    } catch (e) {
      throw Exception('Error fetching user carts: $e');
    }
  }
}