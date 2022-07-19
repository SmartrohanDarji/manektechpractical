import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../../feature/cart_list/models/cart.dart';

class DBHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'cart.db');
    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

// creating database table
  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart(productId VARCHAR  PRIMARY KEY, productName TEXT, price INTEGER, quantity INTEGER, image TEXT)');
  }

// inserting data into the table
  Future<Cart> insert(Cart cart) async {
    var dbClient = await _database;
    await dbClient!.insert('cart', cart.toMap());
    return cart;
  }

  Future<int> checkProductExist(String prodcutId) async {
    var dbClient = await _database;
    var queryResult = await dbClient!
        .rawQuery('SELECT * FROM cart WHERE productId=$prodcutId');
    return queryResult.isNotEmpty
        ? int.parse(queryResult.first["quantity"].toString())
        : 0;
  }

// getting all the items in the list from the database
  Future<List<Cart>> getCartList() async {
    var dbClient = await _database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('cart');
    return queryResult.map((result) => Cart.fromMap(result)).toList();
  }

  Future<int> getCartCount() async {
    var x = await _database?.rawQuery('SELECT COUNT (*) from cart');
    int? count = Sqflite.firstIntValue(x!);
    return count ?? 0;
  }

  Future<int> updateQuantity(Cart cart) async {
    var dbClient = await _database;
    return await dbClient!.update('cart', cart.toMap(),
        where: "productId = ?", whereArgs: [cart.productId]);
  }

// deleting an item from the cart screen
  Future<int> deleteCartItem(int id) async {
    var dbClient = await _database;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }
}
