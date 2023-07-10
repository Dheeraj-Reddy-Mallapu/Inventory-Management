import 'package:flutter/material.dart';
import 'package:inventory_management/hive_classes/order_view_model.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);

    final orders = orderViewModel.allProducts;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Inventory Management'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return ListTile(
                  title: Text(order.dateTime.toString().substring(0, 19)),
                  subtitle: Text(order.products.length.toString()),
                  trailing: Text('Stock: ${order.totalPaid}'),
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
