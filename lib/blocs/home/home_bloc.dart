import 'package:fakeapi/blocs/home/home_event.dart';
import 'package:fakeapi/blocs/home/home_state.dart';
import 'package:fakeapi/repositores/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository productRepository;

  HomeBloc({required this.productRepository}) : super(HomeLoading()) {
    on<LoadProducts>((event, emit) async {
      emit(HomeLoading());
      try {
        final products = await productRepository.fetchProducts();
        emit(HomeLoaded(products: products));
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });
on<FilterProductsByCategory>((event, emit) async {
  emit(HomeLoading());
  try {
    final products = await productRepository.fetchProducts();
    if (event.category == "All") {
      emit(HomeLoaded(products: products));  // "All" seçilirse tüm ürünleri yükle
    } else {
      final filteredProducts = products.where((product) => product.category == event.category).toList();
      emit(HomeLoaded(products: filteredProducts));
    }
  } catch (e) {
    emit(HomeError(message: e.toString()));
  }
});
  }
}