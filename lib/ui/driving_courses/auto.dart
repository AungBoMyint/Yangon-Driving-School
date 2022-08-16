// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'booking.dart';
// import 'manual.dart';
// class AutoPage extends StatefulWidget {
//   const AutoPage({Key key}) : super(key: key);
//
//   @override
//   State<AutoPage> createState() => _AutoPageState();
// }
//
// class _AutoPageState extends State<AutoPage> {
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
//               Image.asset('assets/auto.png',
//                     width: 150,),
//
//               Column(
//                 children: [
//                   ElevatedButton(
//                     child: Text('Package A 90,000 Kyat',
//                     style: TextStyle(fontSize: 14),),
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => Booking()));
//                     },
//                     style: ElevatedButton.styleFrom(
//                         primary: Colors.black,
//                         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         textStyle: TextStyle(
//                             fontSize: 14,
//                             letterSpacing: 1,
//                             wordSpacing: 1,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                   SizedBox(height: 10,),
//                   ElevatedButton(
//                     child: Text('Package B 90,000 Kyat',
//                       style: TextStyle(fontSize: 14),),
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => Booking()));
//                     },
//                     style: ElevatedButton.styleFrom(
//                         primary: Colors.black,
//                         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         textStyle: TextStyle(
//                             fontSize: 14,
//                             letterSpacing: 1,
//                             wordSpacing: 1,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                   SizedBox(height: 10,),
//                   ElevatedButton(
//                     child: Text('Package S 90,000 Kyat',
//                       style: TextStyle(fontSize: 14),),
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                         primary: Colors.black,
//                         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         textStyle: TextStyle(
//                             fontSize: 14,
//                             letterSpacing: 1,
//                             wordSpacing: 1,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                 ],
//               ),
//
//
//
//
//
//             ],),),
//         SizedBox(height: 50),
//         TextCard(),],),);}
//
