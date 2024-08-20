import 'package:fakeapi/models/category_model.dart';
import 'package:fakeapi/services/category_service.dart';

class CategoryRepository {
  final CategoryService categoryService;

  CategoryRepository({required this.categoryService});

  Future<List<Category>> fetchCategories() async {
    final categories = await categoryService.fetchCategories();
    return categories.map((category) => Category.fromJson(category)).toList();
  }
}