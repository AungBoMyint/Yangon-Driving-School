import 'package:json_annotation/json_annotation.dart';

part 'guideline_item.g.dart';

@JsonSerializable()
class GuideLineItem{
  final String id;
  final String parentId;
  final String desc;
  final String image;
  final DateTime dateTime;

  GuideLineItem({
    required this.id,
    required this.parentId,
    required this.desc,
    required this.image,
    required this.dateTime,
  });

  factory GuideLineItem.fromJson(Map<String,dynamic> json) => _$GuideLineItemFromJson(json);

  Map<String,dynamic> toJson() => _$GuideLineItemToJson(this);
}