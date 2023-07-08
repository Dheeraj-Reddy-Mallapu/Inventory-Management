import 'package:flutter/material.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  TextEditingController customerNameC = TextEditingController();
  TextEditingController customerPhNoC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [customerNameC, customerPhNoC];
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 500,
                mainAxisExtent: 50,
                childAspectRatio: 2,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
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
                      labelText: index == 0 ? 'Customer Name' : 'Phone Number',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
