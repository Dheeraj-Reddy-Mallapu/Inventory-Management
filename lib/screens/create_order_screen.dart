import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/hive_classes/order_object.dart';
import 'package:inventory_management/hive_classes/order_view_model.dart';
import 'package:inventory_management/hive_classes/product_object.dart';
import 'package:inventory_management/hive_classes/product_view_model.dart';
import 'package:inventory_management/widgets/build_loading_state.dart';
import 'package:provider/provider.dart';
import 'package:random_string_generator/random_string_generator.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key, required this.isEditMode, required this.index});
  final bool isEditMode;
  final int index;

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  TextEditingController customerNameC = TextEditingController();
  TextEditingController customerPhNoC = TextEditingController();
  TextEditingController notesC = TextEditingController();
  TextEditingController paymentTypeC = TextEditingController();
  TextEditingController totalPaidC = TextEditingController(text: '0');
  List<TextEditingController> quantityCs = [];
  List<TextEditingController> soldAtCs = [];

  List<String> newOrderProductsList = [];

  int totalJmp = 0;
  int totalMrp = 0;

  String id = '';
  int dummy = 0;

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    final orderViewModel = Provider.of<OrderViewModel>(context);

    return orderViewModel.isInitialized ? buildContent(orderViewModel, productViewModel) : buildLoadingState(context);
  }

  Widget buildContent(OrderViewModel orderViewModel, ProductViewModel productViewModel) {
    final color = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;
    final size = MediaQuery.of(context).size;

    final products = productViewModel.allProducts;

    // print(newOrderProductList);

    if (widget.isEditMode && dummy == 0) {
      final orders = orderViewModel.allOrders;
      final order = orders[widget.index];

      final allProductsinOrder = order.products;

      for (int i = 0; i < allProductsinOrder.length; i++) {
        final product = allProductsinOrder[i];
        newOrderProductsList.add(product.keys.first);

        final productData = products.singleWhere((element) => element.id == product.keys.first);

        quantityCs.add(TextEditingController(text: (product.values.first / productData.jmp).round().toString()));
        soldAtCs.add(TextEditingController(text: product.values.first.toString()));
      }

      customerNameC.text = order.customerName;
      customerPhNoC.text = order.customerPhNo.toString();
      totalPaidC.text = order.totalPaid.toString();
      notesC.text = order.notes;
      paymentTypeC.text = order.paymentType;
      totalJmp = order.totalJmp;
      totalMrp = order.totalMrp;
      id = order.id;
      dummy++;
    }

    List<Product> filteredProducts = products.where((element) => newOrderProductsList.contains(element.id)).toList();
    List<Product> inverseFilteredProducts =
        products.where((element) => !newOrderProductsList.contains(element.id)).toList();

    if (soldAtCs.isNotEmpty) {
      totalJmp = 0;
      totalMrp = 0;
      for (int i = 0; i < soldAtCs.length; i++) {
        totalJmp = totalJmp + int.parse(soldAtCs[i].text);
        totalMrp = totalMrp + filteredProducts[i].mrp;
      }
    }
    totalPaidC.text = totalJmp.toString();

    List<TextEditingController> controllers = [customerNameC, customerPhNoC];
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          width: size.width > 1000
              ? 1200
              : size.width > 500
                  ? 1000
                  : 500,
          child: Column(
            children: [
              SizedBox(
                height: size.width > 1000
                    ? 50
                    : size.width > 500
                        ? 100
                        : 150,
                child: GridView.builder(
                  // shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 500,
                    mainAxisExtent: 50,
                    childAspectRatio: 2,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    if (index == 2) {
                      return InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: color.primary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'Add a Product',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: brightness == Brightness.dark ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.defaultDialog(
                            content: SizedBox(
                              height: 500,
                              width: 500,
                              child: ListView.builder(
                                itemCount: inverseFilteredProducts.length,
                                itemBuilder: (context, index) {
                                  final product = inverseFilteredProducts[index];

                                  return ListTile(
                                    title: Text(product.name),
                                    subtitle: Text(product.size),
                                    trailing: Text('Stock: ${product.stock}'),
                                    onTap: () {
                                      newOrderProductsList.add(product.id);
                                      quantityCs.add(TextEditingController(text: '1'));
                                      soldAtCs.add(TextEditingController(text: product.jmp.toString()));
                                      Get.back();
                                      setState(() {});
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controllers[index],
                          keyboardType: index == 1 ? TextInputType.phone : null,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill in the details';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: index == 0 ? 'Customer Name' : 'Customer Phone Number',
                            // labelText: index == 0 ? 'Customer Name' : 'Phone Number',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text('Product Name')),
                    VerticalDivider(),
                    Text('Quantity'),
                    VerticalDivider(),
                    Text('SP'),
                    VerticalDivider(),
                    Text('Sold At'),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: newOrderProductsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(filteredProducts[index].name),
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                InkWell(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: color.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: color.background,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    int count = int.parse(quantityCs[index].text);
                                    if (count > 1) {
                                      count--;
                                      quantityCs[index].text = count.toString();
                                      soldAtCs[index].text =
                                          '${int.parse(filteredProducts[index].jmp.toString()) * int.parse(quantityCs[index].text)}';
                                      setState(() {});
                                    } else {
                                      totalJmp = totalJmp - int.parse(soldAtCs[index].text);
                                      newOrderProductsList.removeAt(index);
                                      soldAtCs.removeAt(index);
                                      quantityCs.removeAt(index);
                                      setState(() {});
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 30,
                                  child: TextFormField(
                                    controller: quantityCs[index],
                                    readOnly: true,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(border: InputBorder.none),
                                  ),
                                ),
                                InkWell(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: color.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: color.background,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    int count = int.parse(quantityCs[index].text);
                                    count++;
                                    quantityCs[index].text = count.toString();
                                    soldAtCs[index].text =
                                        '${int.parse(filteredProducts[index].jmp.toString()) * int.parse(quantityCs[index].text)}';
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          const VerticalDivider(),
                          Text(
                              '${int.parse(filteredProducts[index].jmp.toString()) * int.parse(quantityCs[index].text)}'),
                          const VerticalDivider(),
                          SizedBox(
                            width: 50,
                            child: TextFormField(
                              controller: soldAtCs[index],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Total Paid:'),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    controller: totalPaidC,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: notesC,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill in the details';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Notes',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: paymentTypeC,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill in the details';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Payment Method',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              child: InkWell(
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color.primary,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: brightness == Brightness.dark ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                onTap: () async {
                  id = RandomStringGenerator(fixedLength: 15, hasSymbols: false).generate();

                  List<Map<String, int>> productsInOrder = [];

                  for (int i = 0; i < newOrderProductsList.length; i++) {
                    Map<String, int> productInOrder = {newOrderProductsList[i]: int.parse(soldAtCs[i].text)};
                    productsInOrder.add(productInOrder);

                    // int.parse(soldAtCs[i].text);// TODO
                  }

                  final newOrder = Order(
                    id: id,
                    products: productsInOrder,
                    customerName: customerNameC.text,
                    customerPhNo: int.parse(customerPhNoC.text),
                    dateTime: DateTime.now().toLocal(),
                    totalJmp: totalJmp,
                    totalMrp: totalMrp,
                    totalPaid: int.parse(totalPaidC.text),
                    paymentType: paymentTypeC.text,
                    notes: notesC.text,
                  );

                  if (!widget.isEditMode) {
                    await orderViewModel.addOrder(newOrder);
                  } else {
                    await orderViewModel.updateOrder(newOrder);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
