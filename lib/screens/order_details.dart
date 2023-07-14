import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/hive_classes/order_object.dart';
import 'package:inventory_management/hive_classes/order_view_model.dart';
import 'package:inventory_management/screens/create_order_screen.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.order, required this.index});
  final Order order;
  final int index;

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () => Get.to(() => CreateOrderScreen(isEditMode: true, index: index)),
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
                  leading: const Text('Customer Name', style: TextStyle(fontSize: 20)),
                  trailing: SelectableText(order.customerName, style: const TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: const Text('Customer Phone Number', style: TextStyle(fontSize: 20)),
                  trailing: SelectableText(order.customerPhNo.toString(), style: const TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: const Text('Id', style: TextStyle(fontSize: 20)),
                  trailing: SelectableText(order.id, style: const TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: const Text('Date Time', style: TextStyle(fontSize: 20)),
                  trailing:
                      SelectableText(order.dateTime.toString().substring(0, 19), style: const TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: const Text('Total Amount', style: TextStyle(fontSize: 20)),
                  trailing: SelectableText(order.totalPaid.toString(), style: const TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: const Text('Total JMP', style: TextStyle(fontSize: 20)),
                  trailing: SelectableText(order.totalJmp.toString(), style: const TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: const Text('Total MRP', style: TextStyle(fontSize: 20)),
                  trailing: SelectableText(order.totalMrp.toString(), style: const TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: const Text('Payment Type', style: TextStyle(fontSize: 20)),
                  trailing: SelectableText(order.paymentType, style: const TextStyle(fontSize: 20)),
                ),
                ListTile(
                  leading: const Text('Notes', style: TextStyle(fontSize: 20)),
                  trailing: SelectableText(order.notes, style: const TextStyle(fontSize: 20)),
                ),
                IconButton(
                  onPressed: () => orderViewModel.deleteOrder(index).then((value) => Get.back()),
                  icon: const Icon(Icons.delete_forever),
                ),
                // ListTile(
                //   leading: const Text('Stock', style: TextStyle(fontSize: 20)),
                //   trailing: SelectableText(order.stock.toString(), style: const TextStyle(fontSize: 20)),
                // ),
                // ListTile(
                //   leading: const Text('Company', style: TextStyle(fontSize: 20)),
                //   trailing: SelectableText(order.companyName, style: const TextStyle(fontSize: 20)),
                // ),
                // ListTile(
                //   leading: const Text('MRP', style: TextStyle(fontSize: 20)),
                //   trailing: SelectableText(order.mrp.toString(), style: const TextStyle(fontSize: 20)),
                // ),
                // ListTile(
                //   leading: const Text('JMP', style: TextStyle(fontSize: 20)),
                //   trailing: SelectableText(order.jmp.toString(), style: const TextStyle(fontSize: 20)),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
