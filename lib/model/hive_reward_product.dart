import 'package:hive_flutter/hive_flutter.dart';

part 'hive_reward_product.g.dart';

@HiveType(typeId: 9)
class HiveRewardProduct {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final int count;
  @HiveField(4)
  final int requirePoints;
  HiveRewardProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.count,
    required this.requirePoints,
  });
}
