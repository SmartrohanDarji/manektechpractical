import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech_practical/feature/product_list/bloc/product_event.dart';
import 'package:manektech_practical/feature/product_list/bloc/product_state.dart';

import '../repo/product_list_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductListRepository repository;
  ProductBloc({required this.repository}) : super(Initial());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    yield Loading();
    if (event is GetProductListEvent) {
      final data = await repository.getProductList(event.page, event.perPage);
      yield data.fold((failure) => Error(message: failure.message),
          (r) => GetProductListSuccessfulState(r));
    } else if (event is AddProductToCartEvent) {
      final data = await repository.addProductToCart(event.productId);
      yield data.fold((failure) => Error(message: failure.message),
          (r) => AddProductToCartSuccessfulState(r));
    } else if (event is GetCartCountEvent) {
      final data = await repository.getCartCount();
      yield data.fold((failure) => Error(message: failure.message),
          (r) => GetCartCountSuccessfulState(r));
    } else if (event is GetCartListEvent) {
      final data = await repository.getCartListData();
      final result = data.fold((failure) => Error(message: failure.message),
          (r) => GetCartListSuccessfulState(r));
      yield result;
      if (result is GetCartListSuccessfulState) {
        final data = await repository.getTotalData();
        yield data.fold((failure) => Error(message: failure.message),
            (r) => GetTotalDataSuccessfulState(r));
      }
    }
  }
}
