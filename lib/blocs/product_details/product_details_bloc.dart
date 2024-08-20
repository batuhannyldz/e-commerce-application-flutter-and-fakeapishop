import 'package:fakeapi/blocs/product_details/product_details_event.dart';
import 'package:fakeapi/blocs/product_details/product_details_state.dart';
import 'package:fakeapi/repositores/product_details_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ProductDetailsRepository productDetailsRepository;

  ProductDetailsBloc({required this.productDetailsRepository}) : super(ProductDetailsInitial()) {
    on<LoadProductDetails>(_onLoadProductDetails);
  }

  Future<void> _onLoadProductDetails(
      LoadProductDetails event, Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsLoading());

    try {
      final productDetails = await productDetailsRepository.fetchProductDetails(event.productId);
      emit(ProductDetailsLoaded(productDetails: productDetails));
    } catch (e) {
      emit(ProductDetailsError(message: e.toString()));
    }
  }
}