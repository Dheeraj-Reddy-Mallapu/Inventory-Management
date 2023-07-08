import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/hive_classes/product_object.dart';
import 'package:inventory_management/hive_classes/product_view_model.dart';
import 'package:provider/provider.dart';
import 'package:random_string_generator/random_string_generator.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key, required this.isEditMode});
  final bool isEditMode;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameC = TextEditingController();
  TextEditingController sizeC = TextEditingController();
  TextEditingController mrpC = TextEditingController();
  TextEditingController jmpC = TextEditingController();
  TextEditingController stockC = TextEditingController();
  TextEditingController companyNameC = TextEditingController();

  int dummy = 0;

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);

    if (widget.isEditMode && dummy == 0) {
      dummy++;
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameC,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill in the details';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Name of the product',
                      labelText: 'Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: sizeC,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill in the details';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Size of the product',
                      labelText: 'Size',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: mrpC,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill in the details';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'MRP of the product',
                      labelText: 'MRP',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: jmpC,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill in the details';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'JMP of the product',
                      labelText: 'JMP',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: stockC,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill in the details';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter a number. 0 for out of stock',
                      labelText: 'Stock',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: companyNameC,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill in the details';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Company Name of the product',
                      labelText: 'Company Name',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      // final time = DateTime.now().toLocal().toString().substring(0, 19);
                      final id = RandomStringGenerator(fixedLength: 15, hasSymbols: false).generate();
                      final newProduct = Product(
                        id: id,
                        name: nameC.text,
                        size: sizeC.text,
                        stock: int.parse(stockC.text),
                        companyName: companyNameC.text,
                        jmp: int.parse(jmpC.text),
                        mrp: int.parse(mrpC.text),
                      );

                      if (!widget.isEditMode) {
                        await productViewModel.addProduct(newProduct);
                        Get.back();
                      } else {
                        await productViewModel.updateProduct(newProduct);
                        Get.back();
                      }
                    }
                  },
                  child: const Text('SAVE'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
