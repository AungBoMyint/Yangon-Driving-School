import 'package:hive/hive.dart';

part 'hive_purchase_item.g.dart';

@HiveType(typeId: 6)
class HivePurchaseItem {
  @HiveField(0)
  String itemName;
  @HiveField(1)
  int count;
  @HiveField(2)
  String size;
  @HiveField(3)
  String color;
  @HiveField(4)
  String priceType;
  @HiveField(5)
  int price;
  HivePurchaseItem({
    required this.itemName,
    required this.count,
    required this.size,
    required this.color,
    required this.priceType,
    required this.price,
  });
}
