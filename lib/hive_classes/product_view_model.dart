import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management/hive_classes/product_object.dart';

class ProductViewModel extends ChangeNotifier {
  Box<Product>? productBox;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initProductHive() async {
    // await Hive.initFlutter();
    Hive.registerAdapter(ProductAdapter());
    productBox = await Hive.openBox<Product>('products');
    _isInitialized = true;
    notifyListeners();
  }

  List<Product> get allProducts => productBox!.values.toList();

  Future<void> addProduct(Product product) async {
    await productBox!.add(product);
    notifyListeners();
  }

  Future<void> updateProduct(int productId, Product product) async {
    await productBox!.put(productId, product);
    notifyListeners();
  }

  Future<void> deleteProduct(int index) async {
    await productBox!.deleteAt(index);
    notifyListeners();
  }
}
