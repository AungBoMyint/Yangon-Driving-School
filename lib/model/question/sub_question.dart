import 'package:freezed_annotation/freezed_annotation.dart';

part 'sub_question.freezed.dart';
part 'sub_question.g.dart';

@freezed
class SubQuestion with _$SubQuestion {
  factory SubQuestion({
    required String id,
    required int qNo,
    int? mainQNo,
    required String title,
    required String description,
    required String answer,
    required DateTime dateTime,
    @JsonKey(nullable: true,defaultValue: false)
    bool? isExpanable,
  }) = _SubQuestion;

  factory SubQuestion.fromJson(Map<String,dynamic> json) => _$SubQuestionFromJson(json);
}