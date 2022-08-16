// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guideline_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuideLineItem _$GuideLineItemFromJson(Map<String, dynamic> json) =>
    GuideLineItem(
      id: json['id'] as String,
      parentId: json['parentId'] as String,
      desc: json['desc'] as String,
      image: json['image'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$GuideLineItemToJson(GuideLineItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'desc': instance.desc,
      'image': instance.image,
      'dateTime': instance.dateTime.toIso8601String(),
    };
