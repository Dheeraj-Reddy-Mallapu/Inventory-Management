import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/hive_classes/product_object.dart';
import 'package:inventory_management/screens/add_product_screen.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product, required this.index});
  final Product product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () => Get.to(() => AddProductScreen(isEditMode: true, index: index)),
            child: const Text('Edit'),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 1000,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: const Text('Name', style: TextStyle(fontSize: 20)),
                  trailing: SelectableText(product.name, style: const TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: const Text('Id', style: TextStyle(fontSize: 20)),
                  trailing: SelectableText(product.id, style: const TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: const Text('Size', style: TextStyle(fontSize: 20)),
                  trailing: SelectableText(product.size, style: const TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: const Text('Stock', style: TextStyle(fontSize: 20)),
                  trailing: SelectableText(product.stock.toString(), style: const TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: const Text('Company', style: TextStyle(fontSize: 20)),
                  trailing: SelectableText(product.companyName, style: const TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: const Text('MRP', style: TextStyle(fontSize: 20)),
                  trailing: SelectableText(product.mrp.toString(), style: const TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: const Text('JMP', style: TextStyle(fontSize: 20)),
                  trailing: SelectableText(product.jmp.toString(), style: const TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
