// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cost _$CostFromJson(Map<String, dynamic> json) => Cost(
      id: json['id'] as String,
      desc: json['desc'] as String,
      cost: json['cost'] as int,
    );

Map<String, dynamic> _$CostToJson(Cost instance) => <String, dynamic>{
      'id': instance.id,
      'desc': instance.desc,
      'cost': instance.cost,
    };
