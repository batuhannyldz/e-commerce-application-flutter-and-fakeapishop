import 'package:fakeapi/models/product_model.dart';
import 'package:fakeapi/services/api_service.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository({required this.apiService});

  Future<List<Product>> fetchProducts() async {
    final response = await apiService.fetchProducts();
    // Gelen yanıtı Product nesnelerine dönüştürüyoruz
    return response.map<Product>((json) {
      if (json is Map<String, dynamic>) {
        return Product.fromJson(json);
      } else {
        throw Exception("Invalid data format");
      }
    }).toList();
  }

  Future<List<Product>> searchProducts(String query) async {
    final products = await fetchProducts();  // fetchProducts çağrısı zaten dönüşümü yapıyor
    return products.where((product) => product.title.toLowerCase().contains(query.toLowerCase())).toList();
  }
}