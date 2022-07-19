import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:manektech_practical/core/dbHelper/dbHelper.dart';
import 'package:manektech_practical/feature/cart_list/models/cart.dart';
import 'package:manektech_practical/feature/product_list/models/pagination_model.dart';
import 'package:manektech_practical/feature/product_list/models/total_data_model.dart';
import 'package:manektech_practical/feature/product_list/repo/product_list_repository.dart';

import '../../../core/api_service/api_service.dart';
import '../../../core/failure.dart';
import '../../../core/logger.dart';
import '../models/product_list_model.dart';

class ProductListRepositoryImpl implements ProductListRepository {
  final Dio dio;
  final Connectivity connectivity;
  final DBHelper dbHelper;
  final List<Product> _productList = [];
  final List<Cart> _cartDataList = [];

  ProductListRepositoryImpl(
      {required this.dio, required this.connectivity, required this.dbHelper});

  @override
  Future<Either<Failure, ProductListModel>> getProductList(
      String page, String perPage) async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final param = {"page": page, "perPage": perPage};
      logger.i('requested data for GetProductAPI $param');
      logger.i(
          'requested data for URL ${ApiService.baseUrl + ApiService.productListEndpoint}');
      try {
        final response = await dio.post(
          ApiService.baseUrl + ApiService.productListEndpoint,
          data: param,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "token": ApiService.token
          }),
        );
        logger.i('response for GetProductAPI : ${response.data}');

        var jsonString = json.encode(response.data);
        _productList.clear();
        _productList.addAll(productListModelFromJson(response.data).data);
        logger.i('response for _productList : ${_productList.length}');
        if (response.statusCode == 200) {
          logger.i('GetProductAPI successfully done.');
          return right(ProductListModel(
              status: productListModelFromJson(response.data).status,
              message: productListModelFromJson(response.data).message,
              totalRecord: productListModelFromJson(response.data).totalRecord,
              totalPage: productListModelFromJson(response.data).totalPage,
              data: productListModelFromJson(response.data).data));
        } else {
          return left(Failure("Error status Code : ${response.statusCode}"));
        }
      } on DioError catch (e) {
        logger.e(e.response!.data);
        final message = (e.response!.data
            as Map<String, dynamic>)['error_description'] as String;
        return left(Failure(message));
      } on SocketException catch (e) {
        logger.e(e);
        return left(Failure('Please check the network connection'));
      } on Exception catch (e) {
        logger.e(e);
        return left(Failure('Unexpected Error occurred'));
      }
    } else {
      return left(Failure('Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, String>> addProductToCart(String productId) async {
    final product = _productList
        .firstWhere((element) => element.id.toString() == productId);

    final qty = await dbHelper.checkProductExist(productId);
    logger.i('QTY $qty');
    final cart = Cart(
        productId: productId,
        productName: product.title,
        price: product.price,
        quantity: qty > 0 ? qty + 1 : 1,
        image: product.featuredImage);

    try {
      await qty > 0 ? dbHelper.updateQuantity(cart) : dbHelper.insert(cart);
    } catch (e) {
      return left(Failure("database error occurred."));
    }

    return right("${cart.productName} added to cart.");
  }

  @override
  Future<Either<Failure, int>> getCartCount() async {
    int count = 0;
    try {
      count = await dbHelper.getCartCount();
    } catch (e) {
      return left(Failure("database error occurred."));
    }
    return right(count);
  }

  @override
  Future<Either<Failure, List<Cart>>> getCartListData() async {
    List<Cart> cart = [];
    try {
      cart = await dbHelper.getCartList();
    } catch (e) {
      return left(Failure("database error occurred."));
    }
    return right(cart);
  }

  @override
  Future<Either<Failure, TotalDataModel>> getTotalData() async {
    List<Cart> cart = [];
    int totalPrice = 0;

    try {
      cart = await dbHelper.getCartList();
      for (var element in cart) {
        totalPrice += element.quantity * element.price!;
      }
    } catch (e) {
      return left(Failure("database error occurred."));
    }
    return right(
        TotalDataModel(totalItem: cart.length, grandTotal: totalPrice));
  }

/*  @override
  Either<Failure, Pagination> getPaginationData(int page) {
    int totalPage = 0;
    int selectedPage = 0;
    try {
      totalPage = (totalItems / 5).ceil();
      selectedPage = page;
    } catch (e) {
      return left(Failure("something went wrong"));
    }
    return right(Pagination(page: selectedPage, totalPage: totalPage));
  }*/
}
