import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/hive_classes/order_view_model.dart';
import 'package:inventory_management/screens/order_details.dart';
import 'package:inventory_management/widgets/build_loading_state.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);

    return orderViewModel.isInitialized ? buildContent(orderViewModel) : buildLoadingState(context);
  }

  Widget buildContent(OrderViewModel orderViewModel) {
    final orders = orderViewModel.allOrders;

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
                  trailing: Text('₹ ${order.totalPaid}'),
                  onTap: () {
                    // Perform update or delete operations here
                    Get.to(() => OrderDetails(order: order, index: index));
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
