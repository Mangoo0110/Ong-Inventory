import 'package:fluttertoast/fluttertoast.dart';
import 'package:ong_inventory/data_layer/product_model.dart';
import 'package:sqflite/sqflite.dart' ;
import 'package:path/path.dart';
import 'dart:developer' as devtools show log;

class InventorySqlFlite {
  static Database? _database;

  Future<Database> get database async {
    if(_database != null) {
      return _database!;
    }
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    String path = join(await getDatabasesPath(), "ong_local_storage.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTable,
    );
  }

   Future<void> _createTable(Database db, int version) async{
    await db.execute('''
      CREATE TABLE products(
        productName TEXT PRIMARY KEY,
        price DOUBLE,
        createdAt TEXT,
        priceHistory TEXT
      )
    ''');
  }


  Future<void> insertProduct(Product product) async {
    final Database db = await database;
    
    try {
      await db.insert(
        'products',
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      Fluttertoast.showToast(msg: "Product created!");
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  Future<void> updateProduct(Product product, Product productBefore) async {
    try {
      final Database db = await database;
      await db.update(
        'products',
        product.toMap(),
        where: "productName = ?",
        whereArgs: [productBefore.productName],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      Fluttertoast.showToast(msg: "Product updated!");
    } catch (error) {
      devtools.log(error: error, error.toString());
      print("Product update error: ${error.toString()}");
      Fluttertoast.showToast(msg: "Internal error");
    }
  }

  Future<void> deleteProduct(String productName) async {
    final Database db = await database;
    await db.delete(
      'products',
      where: "productName = ?",
      whereArgs: [productName],
    );
  }

  Future<void> deleteTable() async {
    final Database db = await database;
    await db.database.delete(
      'products',
    );
  }

  Future<List<Product>> getAllProducts() async {
    final Database db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('products');
      return List.generate(maps.length, (index) {
        print(maps[index]);
        devtools.log(maps[index].toString());
        return Product.fromMap(maps[index]);
      });
    } catch (error) {
      print(error);
      devtools.log(error.toString());
      Fluttertoast.showToast(msg: error.toString());
    }
    return <Product>[];
  }
}
