import 'package:flutter/material.dart';
import 'package:inventory_management/hive_classes/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);

    final products = productViewModel.allProducts;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Inventory Management'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.size),
                  trailing: Text('Stock: ${product.stock}'),
                  onTap: () {
                    // Perform update or delete operations here
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
