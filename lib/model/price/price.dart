import 'package:json_annotation/json_annotation.dart';

part 'price.g.dart';

@JsonSerializable()
class Price {
  final String id;
  final String desc;
  final int price;
  final DateTime dateTime;
  Price({required this.id,required this.price,required this.dateTime,
  required this.desc,});

  factory Price.fromJson(Map<String,dynamic> json) => _$PriceFromJson(json);

  Map<String,dynamic> toJson() => _$PriceToJson(this);
}