import 'package:hive/hive.dart';

part 'order_object.g.dart';

@HiveType(typeId: 1)
class Order extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  List<Map<String, int>> products;

  @HiveField(2)
  String customerName;

  @HiveField(3)
  int customerPhNo;

  @HiveField(4)
  DateTime dateTime;

  @HiveField(5)
  int totalJmp;

  @HiveField(6)
  int totalMrp;

  @HiveField(7)
  bool isPaid;

  Order({
    required this.id,
    required this.products,
    required this.customerName,
    required this.customerPhNo,
    required this.dateTime,
    required this.totalJmp,
    required this.totalMrp,
    required this.isPaid,
  });
}
