class RadioModel{
  final String name;
  final dynamic value;
  RadioModel({required this.name,required this.value});
}

class RadioModelWithDescription{
  final String name;
  final String description;
  final dynamic value;
  RadioModelWithDescription({required this.name,
  required this.description,
  required this.value});
}

const classType = [
  "အိမ်အရောက်သင်တန်း",
  "သင်ကြားကွင်းအတန်း",
];

const carType = [
  "Auto gear car",
  "Manual gear car",
];

const dayType = [
  "ကြားရက်သီးသန့်",
  "ပိတ်ရက်အတန်း",
];

const timeType = [
  "မနက်ပိုင်း",
  "ညနေပိုင်း"
];

const licenceType = [
  "'သ' လိုင်စင်",
  "'ခ' လိုင်စင်",
  "'ဃ' လိုင်စင်",
  "'င' လိုင်စင်",
];

const serviceType = [
  "အသစ်/ဖြေ",
  "သက်တမ်းတိုး",
  "အပျောက်",
  "နယ်ပြောင်း",
];

List<String> carEnginList = [
  "660cc-1300cc",
  "1301cc-2000cc",
  "2001cc-4300cc",
  "5400 above",
];