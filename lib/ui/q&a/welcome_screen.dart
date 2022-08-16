// import 'package:card_example/driving_courses/auto.dart';
// import 'package:card_example/q&a/q&a.dart';
// import 'package:card_example/q&a/tab_bar.dart';
// import 'package:flutter/material.dart';
//
// class WelcomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // Fluttter show the back button automatically
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         iconTheme: IconThemeData(
//             color: Colors.black
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           SafeArea(
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Image.asset(
//                       'assets/cq.png',
//                       width: 300,
//                       height: 300,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//
//
//                   Text(
//                     "ယာဉ်ကိုစည်းစနစ်တကျ နှင့် ဘေးအန္တရာယ်ကင်းစွာမောင်းနှင်နိုင်ရန် လေ့ကျင့်သင့်သောမေးခွန်းနှင့်အဖြေများ",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//
//                       fontSize: 18,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold
//                     ),
//                   ),
//                   // Text("Enter your informations below"),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Center(
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(4),
//                       child: Stack(
//                         children: <Widget>[
//                           Positioned.fill(
//                             child: Container(
//                               decoration: const BoxDecoration(
//                                 gradient: LinearGradient(
//                                   colors: <Color>[
//                                     Color(0xFF0D47A1),
//                                     Color(0xFF0D47A1),
//                                     Color(0xFF0D47A1),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//
//
//       TextButton(
//         style: TextButton.styleFrom(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           primary: Colors.indigo,
//           textStyle: const TextStyle(fontSize: 20),),
//         onPressed: () {
//         Navigator.push(context,
//               MaterialPageRoute(builder: (context) => TabBars()));
//         },
//         child: const Text('စတင်ရန်',
//           style: TextStyle(
//           color: Colors.white,
//           fontSize: 18,
//         ),),
//       ),
//                 ],
//               ),
//           ),
//                   ),
//         ],
//       ),
//     ),
//
//     ],
//       ),
//     );
//   }
// }
