import 'package:fakeapi/blocs/search/search_event.dart';
import 'package:fakeapi/blocs/search/search_state.dart';
import 'package:fakeapi/repositores/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductRepository productRepository;

  SearchBloc({required this.productRepository}) : super(SearchInitial()) {
    on<SearchQueryChanged>((event, emit) async {
      emit(SearchLoading());
      try {
        final products = await productRepository.searchProducts(event.query);
        emit(SearchLoaded(products: products));
      } catch (e) {
        emit(SearchError(message: e.toString()));
      }
    });
  }
}