import 'package:hive/hive.dart';

part 'product_object.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String size;

  @HiveField(3)
  int stock;

  @HiveField(4)
  String companyName;

  @HiveField(5)
  int jmp;

  @HiveField(6)
  int mrp;

  Product({
    required this.id,
    required this.name,
    required this.size,
    required this.stock,
    required this.companyName,
    required this.jmp,
    required this.mrp,
  });
}
