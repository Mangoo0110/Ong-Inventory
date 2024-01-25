import 'package:ong_inventory/data_layer/inventory_storage.dart';
import 'package:ong_inventory/data_layer/product_model.dart';
class ProductDomain {
  Future<List<Product>> getAllProducts () async{
    List<Product> products = [];
    //await InventorySqlFlite().deleteProduct("Mango juice 250ml");
    products = await InventorySqlFlite().getAllProducts();
    // if(products.isEmpty) {
    //   await Fluttertoast.showToast(msg: "You have ${products.length} products.");
    // }
    print(products.length);
    return products;
  }
  Future<void>createProduct ({
    required String productName,
    required double price
  }) async {
    
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
    Product newProduct = Product(productName: productName, price: price, createdAt: now, priceHistory: {now : price});
    await InventorySqlFlite().insertProduct(newProduct);
  }

  Future<void>updateProduct ({
    required String productName,
    required double price,
    required Product productBefore
  }) async {
    
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
    Product modifiedProduct = Product(productName: productName, price: price, createdAt: productBefore.createdAt, priceHistory: productBefore.priceHistory);
    if(productBefore.productName == modifiedProduct.productName && productBefore.price == modifiedProduct.price) return;
    if(productBefore.price != modifiedProduct.price) {
      modifiedProduct.priceHistory.addEntries({now : price}.entries);
    }
    await InventorySqlFlite().updateProduct(modifiedProduct, productBefore);
  }
}