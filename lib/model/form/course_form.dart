import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hammies_user/model/price/price.dart';

part 'course_form.freezed.dart';
part 'course_form.g.dart';

@freezed
class CourseForm with _$CourseForm{
  @JsonSerializable(explicitToJson: true)
  factory CourseForm({
    required String id,
  required String name,
  required String fatherName,
  required String idNo,
  required String address,
  required String phoneNumber,
  required String courseType,
  required String carType,
  required String dayType,
  required DateTime initialDay,
  required String timeType,
  required Price price,
  required String userID,
  required bool isConfirmed,
  @JsonKey(nullable: true) String? bankSlipImage,
  required DateTime dateTime,
  }) = _CourseForm;
  factory CourseForm.fromJson(Map<String,dynamic> json) => _$CourseFormFromJson(json);
}