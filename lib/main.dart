import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management/hive_classes/order_view_model.dart';
import 'package:inventory_management/hive_classes/product_view_model.dart';
// import 'package:inventory_management/hive_classes/order_object.dart';
// import 'package:inventory_management/hive_classes/product_object.dart';
import 'package:inventory_management/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();

  // Hive.registerAdapter(ProductAdapter());
  // await Hive.openBox<Product>('products');

  // Hive.registerAdapter(OrderAdapter());
  // await Hive.openBox<Product>('orders');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: ((ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductViewModel>(create: (_) => ProductViewModel()..initProductHive()),
          ChangeNotifierProvider<OrderViewModel>(create: (_) => OrderViewModel()..initOrderHive()),
        ],
        child: GetMaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightDynamic ?? _defaultLightColorScheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkDynamic ?? _defaultDarkColorScheme,
          ),
          home: const HomeScreen(),
        ),
      );
    }));
  }
}

final _defaultLightColorScheme = ColorScheme.fromSeed(seedColor: Colors.yellow);

final _defaultDarkColorScheme = ColorScheme.fromSeed(seedColor: Colors.yellow, brightness: Brightness.dark);
