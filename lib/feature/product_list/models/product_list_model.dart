// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) =>
    ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) =>
    json.encode(data.toJson());

class ProductListModel {
  ProductListModel({
    required this.status,
    required this.message,
    required this.totalRecord,
    required this.totalPage,
    required this.data,
  });

  int status;
  String message;
  int totalRecord;
  int totalPage;
  List<Product> data;

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        status: json["status"],
        message: json["message"],
        totalRecord: json["totalRecord"],
        totalPage: json["totalPage"],
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "totalRecord": totalRecord,
        "totalPage": totalPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.price,
    required this.featuredImage,
    required this.status,
    required this.createdAt,
  });

  int id;
  String slug;
  String title;
  String description;
  int price;
  String featuredImage;
  String status;
  DateTime createdAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        slug: json["slug"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        featuredImage: json["featured_image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "title": title,
        "description": description,
        "price": price,
        "featured_image": featuredImage,
        "status": status,
        "created_at": createdAt.toIso8601String(),
      };
}
