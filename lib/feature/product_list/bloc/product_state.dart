import 'package:manektech_practical/feature/product_list/models/pagination_model.dart';
import 'package:manektech_practical/feature/product_list/models/total_data_model.dart';

import '../../cart_list/models/cart.dart';
import '../models/product_list_model.dart';

abstract class ProductState {}

class Initial extends ProductState {}

class Loading extends ProductState {}

class GetProductListSuccessfulState extends ProductState {
  final ProductListModel productListModel;

  GetProductListSuccessfulState(this.productListModel);
}

class AddProductToCartSuccessfulState extends ProductState {
  final String message;

  AddProductToCartSuccessfulState(this.message);
}

class GetCartCountSuccessfulState extends ProductState {
  final int count;

  GetCartCountSuccessfulState(this.count);
}

class GetTotalDataSuccessfulState extends ProductState {
  final TotalDataModel totalDataModel;

  GetTotalDataSuccessfulState(this.totalDataModel);
}

class SelectPageState extends ProductState {
  final Pagination pagination;

  SelectPageState(this.pagination);
}

class GetCartListSuccessfulState extends ProductState {
  final List<Cart> cartList;

  GetCartListSuccessfulState(this.cartList);
}

class Error extends ProductState {
  final String message;

  Error({required this.message});
}
