// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Question _$$_QuestionFromJson(Map<String, dynamic> json) => _$_Question(
      id: json['id'] as String,
      qNo: json['qNo'] as int,
      title: json['title'] as String,
      isExpanded: json['isExpanded'] as bool? ?? false,
    );

Map<String, dynamic> _$$_QuestionToJson(_$_Question instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qNo': instance.qNo,
      'title': instance.title,
      'isExpanded': instance.isExpanded,
    };
