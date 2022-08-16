import 'package:freezed_annotation/freezed_annotation.dart';

part 'driving_licence_form.freezed.dart';
part 'driving_licence_form.g.dart';

@freezed
class DrivingLicenceForm with _$DrivingLicenceForm{
  factory DrivingLicenceForm({
   required String id,
  required String name,
  required String fatherName,
  required String dateOfBirth,
  required String idNo,
  required String address,
  required String phoneNumber,
  required String? licenceNo,
  required String? licenceExpiredDate,
  required String licenceType,
  required String serviceType,
  required bool isConfirmed,
  required int cost,
  required String userId,
  @JsonKey(nullable: true) String? bankSlipImage,
  required DateTime dateTime,
  }) = _DrivingLicenceForm;

  factory DrivingLicenceForm.fromJson(Map<String,dynamic> json) => _$DrivingLicenceFormFromJson(json);
}