import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management/hive_classes/product_object.dart';
import 'package:inventory_management/hive_classes/product_view_model.dart';
import 'package:inventory_management/widgets/my_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:random_string_generator/random_string_generator.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key, required this.isEditMode, required this.index});
  final bool isEditMode;
  final int index;

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
  String id = '';

  int dummy = 0;

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    final products = productViewModel.allProducts;

    if (widget.isEditMode && dummy == 0) {
      nameC.text = products[widget.index].name;
      sizeC.text = products[widget.index].size;
      mrpC.text = products[widget.index].mrp.toString();
      jmpC.text = products[widget.index].jmp.toString();
      stockC.text = products[widget.index].stock.toString();
      companyNameC.text = products[widget.index].companyName;
      id = products[widget.index].id;
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
                      id = RandomStringGenerator(fixedLength: 15, hasSymbols: false).generate();
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
                      // ignore: use_build_context_synchronously
                      MySnackbar().show(context, 'Hurray!', 'Saved the product', ContentType.success);
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
