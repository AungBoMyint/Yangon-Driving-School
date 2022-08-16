import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
class Question with _$Question {
  factory Question({
    required String id,
    required int qNo,
    required String title,
    @JsonKey(nullable: true,defaultValue: false)
    bool? isExpanded,
  }) = _Question;

  factory Question.fromJson(Map<String,dynamic> json) => _$QuestionFromJson(json);
}