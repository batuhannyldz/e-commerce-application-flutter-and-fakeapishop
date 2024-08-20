import 'package:fakeapi/services/cart_service.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartService _cartService = CartService();
  Map<String, dynamic>? _cart;

  @override
  void initState() {
    super.initState();
    _fetchCart();
  }

  Future<void> _fetchCart() async {
    try {
      final cart = await _cartService.getCartById(1); // Sabit bir cart ID ile çağırıyoruz
      setState(() {
        _cart = cart;
      });
    } catch (e) {
      // Hata durumunda, durumu kullanıcıya gösterebiliriz
      print('Error fetching cart: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: _cart == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _cart!['products'].length,
              itemBuilder: (context, index) {
                final product = _cart!['products'][index];
                return FutureBuilder<Map<String, dynamic>>(
                  future: _cartService.getProductDetails(product['productId']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        title: Text('Loading...'),
                        subtitle: Text('Quantity: ${product['quantity']}'),
                        leading: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return ListTile(
                        title: Text('Error loading product'),
                        subtitle: Text('Quantity: ${product['quantity']}'),
                      );
                    } else if (snapshot.hasData) {
                      final productData = snapshot.data!;
                      return ListTile(
                        leading: Image.network(
                          productData['image'],
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error); // Eğer resim yüklenmezse bir hata ikonu göster
                          },
                        ),
                        title: Text(productData['title']),
                        subtitle: Text('Quantity: ${product['quantity']}'),
                      );
                    } else {
                      return ListTile(
                        title: Text('Unknown Error'),
                        subtitle: Text('Quantity: ${product['quantity']}'),
                      );
                    }
                  },
                );
              },
            ),
    );
  }
}