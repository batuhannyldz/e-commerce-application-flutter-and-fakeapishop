import 'package:fakeapi/blocs/product_details/product_details_bloc.dart';
import 'package:fakeapi/blocs/product_details/product_details_event.dart';
import 'package:fakeapi/blocs/product_details/product_details_state.dart';
import 'package:fakeapi/models/product_details_model.dart';
import 'package:fakeapi/repositores/product_details_repository.dart';
import 'package:fakeapi/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  ProductDetailsScreen({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ürün Detayları')),
      body: BlocProvider(
        create: (context) => ProductDetailsBloc(
          productDetailsRepository: ProductDetailsRepository(apiService: ApiService()),
        )..add(LoadProductDetails(productId: productId)),
        child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailsLoaded) {
              final ProductDetails product = state.productDetails;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        product.image,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      product.title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '\$${product.price}',
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                    SizedBox(height: 10),
                    Text(
                      product.description,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Category: ${product.category}',
                      style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Sepete ekleme işlemi
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${product.title} sepete eklendi')),
                          );
                        },
                        child: Text('Sepete Ekle'),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ProductDetailsError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('Bilinmeyen bir hata oluştu!'));
            }
          },
        ),
      ),
    );
  }
}