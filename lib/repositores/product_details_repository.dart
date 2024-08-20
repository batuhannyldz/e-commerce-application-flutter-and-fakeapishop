import 'package:fakeapi/models/product_details_model.dart';
import 'package:fakeapi/services/api_service.dart';

class ProductDetailsRepository {
  final ApiService apiService;

  ProductDetailsRepository({required this.apiService});

  Future<ProductDetails> fetchProductDetails(int id) async {
    final Map<String, dynamic> response = await apiService.fetchProductById(id);
    return ProductDetails.fromJson(response);
  }
}