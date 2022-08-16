// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// class ManualPage extends StatefulWidget {
//   const ManualPage({Key key}) : super(key: key);
//
//   @override
//   State<ManualPage> createState() => _ManualPageState();
// }
//
// class _ManualPageState extends State<ManualPage> {
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
//               Image.asset('assets/manual.png',
//                 width: 150,),
//
//               Column(
//                 children: [
//                   ElevatedButton(
//                     child: Text('Package M 90,000 Kyat',
//                       style: TextStyle(fontSize: 14),),
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                         primary: Colors.black,
//                         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                         textStyle: TextStyle(
//                             fontSize: 14,
//                             letterSpacing: 1,
//                             wordSpacing: 1,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                   SizedBox(height: 10,),
//                   ElevatedButton(
//                     child: Text('Package BM 200,000 Kyat',
//                       style: TextStyle(fontSize: 14),),
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                         primary: Colors.black,
//                         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//                         textStyle: TextStyle(
//                             fontSize: 14,
//                             letterSpacing: 1,
//                             wordSpacing: 1,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                   SizedBox(height: 10,),
//                   ElevatedButton(
//                     child: Text('Package SM 350,000 Kyat',
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
//                   SizedBox(height: 10,),
//                   ElevatedButton(
//                     child: Text('Package Bus 450,000 Kyat',
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
//
//
// Widget TextCard() => Padding(
//   padding: const EdgeInsets.only(left: 20, right: 20),
//   child:   Card(
//     elevation: 5,
//     child: Padding(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '၉၀၀၀၀ ကျပ်တန် သင်တန်းအားလုံးသည် သင်တန်းကွင်းသို့ လာရောက်သင်ကြားရမည် ။',
//             style: TextStyle(fontSize: 16,
//             fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 10,),
//           Text(
//             'DOOR TO DOOR သင်တန်းများသည် သင်တန်းချိန် စသင်မှသာ အချိန်စမှတ်သည် ။',
//             style: TextStyle(fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 10,),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Text(
//                 'ရန်ကုန်ကားမောင်းသင်တန်း',
//                 style: TextStyle(fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   ),
// );
