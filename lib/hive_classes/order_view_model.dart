import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management/hive_classes/order_object.dart';

class OrderViewModel extends ChangeNotifier {
  Box<Order>? _orderBox;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initOrderHive() async {
    // await Hive.initFlutter();
    Hive.registerAdapter(OrderAdapter());
    _orderBox = await Hive.openBox<Order>('orders');
    _isInitialized = true;
    notifyListeners();
  }

  List<Order> get allOrders => _orderBox!.values.toList();

  Future<void> addOrder(Order order) async {
    await _orderBox!.add(order);
    notifyListeners();
  }

  Future<void> updateOrder(Order order) async {
    await order.save();
    notifyListeners();
  }

  Future<void> deleteOrder(int index) async {
    await _orderBox!.deleteAt(index);
    notifyListeners();
  }
}
