import 'package:manektech_practical/feature/cart_list/models/cart.dart';

abstract class ProductEvent {}

class GetProductListEvent extends ProductEvent {
  String page;
  String perPage;
  GetProductListEvent(this.page, this.perPage);
}

class AddProductToCartEvent extends ProductEvent {
  String productId;
  AddProductToCartEvent(this.productId);
}

class GetCartCountEvent extends ProductEvent {
  GetCartCountEvent();
}

/*class SelectPageEvent extends ProductEvent {
  int page;
  SelectPageEvent(this.page);
}*/

class GetTotalDataEvent extends ProductEvent {
  GetTotalDataEvent();
}

class GetCartListEvent extends ProductEvent {}
