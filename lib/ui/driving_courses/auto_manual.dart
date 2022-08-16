// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'auto.dart';
// import 'manual.dart';
//
// class AutoManual extends StatefulWidget {
//   const AutoManual({Key key}) : super(key: key);
//
//   @override
//   State<AutoManual> createState() => _AutoManualState();
// }
//
// class _AutoManualState extends State<AutoManual> {
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       backgroundColor: Colors.grey,
//       title: Row(
//         children: [
//           Image.asset(
//             'assets/logo.png',
//             fit: BoxFit.contain,
//             height: 40,
//           ),
//           Container(
//             padding: const EdgeInsets.all(8.0), child: Text('YANGON DRIVING SCHOOL',
//             style: TextStyle(fontSize: 16,
//                 wordSpacing: 2, letterSpacing: 2),),)
//         ],
//       ),
//     ),
//
//     body: Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 30),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               FlatButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => AutoPage()));
//                   },
//                   child: Image.asset('assets/auto.png',
//                   width: 150,)),
//
//               FlatButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => ManualPage()));
//                   },
//                   child: Image.asset('assets/manual.png',
//                     width: 141,)),
//             ],
//           ),
//         ),
//
//         SizedBox(
//           height: 50,
//         ),
//         TextCard(),
//       ],
//     ),
//
//   );
//   }
