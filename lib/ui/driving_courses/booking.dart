import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/home_items.dart';
import '../../widgets/home_pickup.dart';
import 'manual.dart';
class Booking extends StatefulWidget {
  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.grey,
      title: Row(
        children: [
          Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            height: 40,
          ),
          Container(
            padding: const EdgeInsets.all(8.0), child: Text('YANGON DRIVING SCHOOL',
            style: TextStyle(fontSize: 16,
                wordSpacing: 2, letterSpacing: 2),),)
        ],
      ),
    ),

    body: SingleChildScrollView(
      child: Column(
        children: [
          HomePickUp(),
          HomeItems(),
          // Padding(
          //   padding: const EdgeInsets.only(top: 30),
          //   child: Text("Package A (Auto Only 90,000 Kyats)",
          //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
          //     wordSpacing: 1,
          //     letterSpacing: 1),
          //   ),
          // ),
          // SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20,right: 20),
          //   child: Text("Auto သီးသန့်အတန်းဖြစ်ပြီး သင်ကြားကွင်း (သုဝဏ္ဏ၊လှိုင်၊မြောက်ဒဂုံ၊မင်္ဂလာဒုံ၊လှိုင်သာယာ၊မှော်ဘီ) စသည်တို့တွင် လာရောက်သင်ကြားရမည်။ (တစ်ရက် ၁နာရီ ၈ရက်) သင်ကြားပေးမှာဖြစ်ပြီး မနက် ရး၀၀ မှ ညနေ ၄း၀၀ အတွင်းစိတ်ကြိုက် အချိန်ရွေးချယ်၍ စနေ/တနင်္ဂနွေ သို့မဟုတ် ကြားရက် သင်ကြားနိုင်သည်။"),
          // ),
          // SizedBox(height: 20),
          // ElevatedButton(
          //   child: Text('Booking Now',
          //     style: TextStyle(fontSize: 14),),
          //   onPressed: () {
          //     // Navigator.push(context,
          //     //     MaterialPageRoute(builder: (context) => SRForm()));
          //   },
          //   style: ElevatedButton.styleFrom(
          //       primary: Colors.red,
          //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          //       textStyle: TextStyle(
          //           fontSize: 14,
          //           letterSpacing: 1,
          //           wordSpacing: 1,
          //           fontWeight: FontWeight.bold)),
          // ),
          //
          // SizedBox(height: 20,),

          // TextCard(),

        ],),
    ),);}

