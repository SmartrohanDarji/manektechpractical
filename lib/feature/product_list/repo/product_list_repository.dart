import 'package:dartz/dartz.dart';
import 'package:manektech_practical/feature/product_list/models/pagination_model.dart';
import 'package:manektech_practical/feature/product_list/models/total_data_model.dart';

import '../../../core/failure.dart';
import '../../cart_list/models/cart.dart';
import '../models/product_list_model.dart';

abstract class ProductListRepository {
//  Future<Either<Failure, Failure>> getProductList();
  Future<Either<Failure, ProductListModel>> getProductList(
      String page, String perPage);
  Future<Either<Failure, String>> addProductToCart(String productId);
  Future<Either<Failure, int>> getCartCount();
  Future<Either<Failure, List<Cart>>> getCartListData();
  Future<Either<Failure, TotalDataModel>> getTotalData();
}
