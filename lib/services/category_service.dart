import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryService {
  final String _baseUrl = 'https://fakestoreapi.com';

  Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/products/categories'));

    if (response.statusCode == 200) {
      List<dynamic> categoriesJson = json.decode(response.body);
      return categoriesJson.map((category) => category.toString()).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}