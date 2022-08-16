// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class CLForm extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return CLFormState();
//   }
// }
//
// class CLFormState extends State<CLForm> {
//   String _name;
//   String _fathername;
//   String _dateofbirth;
//   String _nrc;
//   String _address;
//   String _phoneNumber;
//   String _pickuptime;
//   String _vehicleNo;
//   String _office;
//   String _vehiclelicenseexpiredate;
//
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   Widget _buildName() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'ပြုလုပ်သူအမည်'),
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Name is Required';
//         }
//
//         return null;
//       },
//       onSaved: (String value) {
//         _name = value;
//       },
//     );
//   }
//   Widget _buildFatherName() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'အဖအမည်'),
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Name is Required';
//         }
//
//         return null;
//       },
//       onSaved: (String value) {
//         _fathername = value;
//       },
//     );
//   }
//   Widget _buildDateofBirth() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'မွေးသက္ကရာဇ်'),
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Name is Required';
//         }
//
//         return null;
//       },
//       onSaved: (String value) {
//         _dateofbirth = value;
//       },
//     );
//   }
//   Widget _buildNRC() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'မှတ်ပုံတင်အမှတ်'),
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Name is Required';
//         }
//
//         return null;
//       },
//       onSaved: (String value) {
//         _nrc = value;
//       },
//     );
//   }
//   Widget _buildAddress() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'လိပ်စာ'),
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Name is Required';
//         }
//
//         return null;
//       },
//       onSaved: (String value) {
//         _address = value;
//       },
//     );
//   }
//
//   Widget _buildvehicleNo() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'ကားနံပါတ်'),
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Vehicle Number is Required';
//         }
//
//         return null;
//       },
//       onSaved: (String value) {
//         _vehicleNo = value;
//       },
//     );
//   }
//
//   Widget _buildoffice() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'လုပ်ငန်းဆောင်ရွက်ရန်ရုံး'),
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Proceed Office is Required';
//         }
//
//         return null;
//       },
//       onSaved: (String value) {
//         _office = value;
//       },
//     );
//   }
//
//
//
//   Widget _buildvehicleLicenseExpiredate() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'ကားလိုင်စင်သက်တမ်း ကုန်ဆုံးမည့်နေ့'),
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Vehicle Expire Date is Required';
//         }
//
//         return null;
//       },
//       onSaved: (String value) {
//         _vehiclelicenseexpiredate = value;
//       },
//     );
//   }
//
//
//   Widget _buildPhoneNumber() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'ဖုန်း'),
//       keyboardType: TextInputType.phone,
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Phone number is Required';
//         }
//
//         return null;
//       },
//       onSaved: (String value) {
//       },
//     );
//   }
//   Widget _buildPickupTime() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: '(မူရင်း)လာရောက်ယူဆောင်ရမည့်အချိန်'),
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Name is Required';
//         }
//
//         return null;
//       },
//       onSaved: (String value) {
//         _name = value;
//       },
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey,
//         title: Row(
//           children: [
//             Image.asset(
//               'assets/logo.png',
//               fit: BoxFit.contain,
//               height: 40,
//             ),
//             Container(
//               padding: const EdgeInsets.all(8.0), child: Text("Vehicle License Form",
//               style: TextStyle(fontSize: 16,
//                   wordSpacing: 2, letterSpacing: 2),),)
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.all(24),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 _buildName(),
//                 SizedBox(height: 10),
//                 _buildFatherName(),
//                 SizedBox(height: 10),
//                 _buildDateofBirth(),
//                 SizedBox(height: 10),
//                 BasicDateTimeField(),
//                 SizedBox(height: 10),
//                 _buildNRC(),
//                 SizedBox(height: 10),
//                 _buildAddress(),
//                 SizedBox(height: 10),
//                 _buildPhoneNumber(),
//                 SizedBox(height: 10),
//                 _buildPickupTime(),
//                 SizedBox(height: 30),
//                 _buildvehicleNo(),
//                 SizedBox(height: 30),
//                 _buildvehicleLicenseExpiredate(),
//                 SizedBox(height: 30),
//                 _buildoffice(),
//                 SizedBox(height: 30),
//
//                 RaisedButton(
//                   child: Text(
//                     'စာရင်းသွင်းရန်',
//                     style: TextStyle(color: Colors.indigo, fontSize: 16),
//                   ),
//                   onPressed: () {
//                     if (!_formKey.currentState.validate()) {
//                       return;
//                     }
//
//                     _formKey.currentState.save();
//
//                     print(_name);
//                     print(_fathername);
//                     print(_dateofbirth);
//                     print(_nrc);
//                     print(_address);
//                     print(_phoneNumber);
//                     print(_vehicleNo);
//                     print(_vehiclelicenseexpiredate);
//
//                     //Send to API
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class BasicDateTimeField extends StatelessWidget {
//   final format = DateFormat("yyyy-MM-dd HH:mm");
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       Text('Basic date & time field (${format.pattern})'),
//       DateTimeField(
//         // format: format,
//         onShowPicker: (context, currentValue) async {
//           final date = await showDatePicker(
//               context: context,
//               firstDate: DateTime(1900),
//               initialDate: currentValue ?? DateTime.now(),
//               lastDate: DateTime(2100));
//           if (date != null) {
//             final time = await showTimePicker(
//               context: context,
//               initialTime:
//               TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
//             );
//             return DateTimeField.combine(date, time);
//           } else {
//             return currentValue;
//           }
//         },
//       ),
//     ]);
//   }
// }