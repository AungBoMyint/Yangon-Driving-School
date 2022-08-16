
import 'package:freezed_annotation/freezed_annotation.dart';

part 'car_licence_form.freezed.dart';
part 'car_licence_form.g.dart';

@freezed
class CarLicenceForm with _$CarLicenceForm{
  factory CarLicenceForm({
   required String id,
  required String name,
  required String idNo,
  required String address,
  required String phoneNumber,
  required String carNo,
  required String carExpiredDate,
  required String enginPowerType,
  required String? toDoFromOffice,
  required bool isConfirmed,
  required int cost,
  required String userId,
  @JsonKey(nullable: true) String? bankSlipImage,
  required DateTime dateTime,
  }) = _CarLicenceForm;
  factory CarLicenceForm.fromJson(Map<String,dynamic> json) => _$CarLicenceFormFromJson(json);
}