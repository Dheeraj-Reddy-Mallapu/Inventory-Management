import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management/hive_classes/product_object.dart';

class ProductViewModel extends ChangeNotifier {
  Box<Product>? _productBox;

  Future<void> initProductHive() async {
    // await Hive.initFlutter();
    Hive.registerAdapter(ProductAdapter());
    _productBox = await Hive.openBox<Product>('products');
    notifyListeners();
  }

  List<Product> get allProducts => _productBox!.values.toList();

  Future<void> addProduct(Product product) async {
    await _productBox!.add(product);
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    await product.save();
    notifyListeners();
  }

  Future<void> deleteProduct(int index) async {
    await _productBox!.deleteAt(index);
    notifyListeners();
  }
}
