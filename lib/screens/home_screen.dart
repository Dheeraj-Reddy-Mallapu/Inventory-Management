import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/hive_classes/export_data.dart';
import 'package:inventory_management/screens/add_product_screen.dart';
import 'package:inventory_management/screens/create_order_screen.dart';
import 'package:inventory_management/screens/orders_screen.dart';
import 'package:inventory_management/screens/products_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Inventory Management'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => Get.to(() => const AddProductScreen(isEditMode: false, index: 0)),
              child: const Text('Add a Product'),
            ),
            ElevatedButton(
              onPressed: () => Get.to(() => const ProductsScreen()),
              child: const Text('View All Products'),
            ),
            ElevatedButton(
              onPressed: () => Get.to(() => const CreateOrderScreen()),
              child: const Text('New Order'),
            ),
            ElevatedButton(
              onPressed: () => Get.to(() => const OrdersScreen()),
              child: const Text('View All Orders'),
            ),
            ElevatedButton(
              onPressed: () {
                exportHiveData(context, 'products');
              },
              child: const Text('Export Products Data'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     importHiveData('products');
            //   },
            //   child: const Text('Import Products Data'),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     importHiveData('orders');
            //   },
            //   child: const Text('Import Orders Data'),
            // ),
            ElevatedButton(
              onPressed: () {
                exportHiveData(context, 'orders');
              },
              child: const Text('Export Orders Data'),
            ),
          ],
        ),
      ),
    );
  }
}
