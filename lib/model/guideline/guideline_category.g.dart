// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guideline_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuideLineCategory _$GuideLineCategoryFromJson(Map<String, dynamic> json) =>
    GuideLineCategory(
      id: json['id'] as String,
      title: json['title'] as String,
      color: json['color'] as String,
      image: json['image'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$GuideLineCategoryToJson(GuideLineCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'color': instance.color,
      'image': instance.image,
      'dateTime': instance.dateTime.toIso8601String(),
    };
