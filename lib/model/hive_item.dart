import 'package:hive/hive.dart';

part 'hive_item.g.dart';

@HiveType(typeId: 1)
class HiveItem {
  @HiveField(0)
  String id;
  @HiveField(1)
  String photo;
  @HiveField(2)
  String photo2;
  @HiveField(3)
  String photo3;
  @HiveField(4)
  String desc;
  @HiveField(5)
  String name;
  @HiveField(6)
  String deliverytime;
  @HiveField(7)
  int price;
  @HiveField(8)
  String color;
  @HiveField(9)
  String size;
  @HiveField(10)
  int star;
  @HiveField(11)
  String category;

  @HiveField(12)
  int originalPrice;

  @HiveField(13)
  int originalQuantity;

  @HiveField(14)
  int remainQuantity;
  HiveItem({
    required this.id,
    required this.photo,
    required this.photo2,
    required this.photo3,
    required this.name,
    required this.deliverytime,
    required this.price,
    required this.desc,
    required this.color,
    required this.size,
    required this.star,
    required this.category,
    required this.originalPrice,
    required this.originalQuantity,
    required this.remainQuantity,
  });
}
