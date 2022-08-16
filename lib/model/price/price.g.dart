// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      id: json['id'] as String,
      price: json['price'] as int,
      dateTime: DateTime.parse(json['dateTime'] as String),
      desc: json['desc'] as String,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'id': instance.id,
      'desc': instance.desc,
      'price': instance.price,
      'dateTime': instance.dateTime.toIso8601String(),
    };
