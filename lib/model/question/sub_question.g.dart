// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SubQuestion _$$_SubQuestionFromJson(Map<String, dynamic> json) =>
    _$_SubQuestion(
      id: json['id'] as String,
      qNo: json['qNo'] as int,
      mainQNo: json['mainQNo'] as int?,
      title: json['title'] as String,
      description: json['description'] as String,
      answer: json['answer'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      isExpanable: json['isExpanable'] as bool? ?? false,
    );

Map<String, dynamic> _$$_SubQuestionToJson(_$_SubQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qNo': instance.qNo,
      'mainQNo': instance.mainQNo,
      'title': instance.title,
      'description': instance.description,
      'answer': instance.answer,
      'dateTime': instance.dateTime.toIso8601String(),
      'isExpanable': instance.isExpanable,
    };
