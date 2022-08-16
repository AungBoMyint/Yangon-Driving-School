import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hammies_user/routes/routes.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'screen/home_screen.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return IntroductionScreen(
      isTopSafeArea: true,
      controlsPadding: const EdgeInsets.all(0),
      controlsMargin: const EdgeInsets.all(0),
      pages: [
        PageViewModel(
          title: "",
          //body: "",
          bodyWidget: Center(child: Image.asset('assets/s1.png',height: size.height,)),//buildImage('assets/s1.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "",
          //body: '''''',
          bodyWidget: buildImage('assets/s3.png',size.height),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: '',
          //body: '''''',
          footer: ButtonWidget(
            text: "LET'S GET STARTED",
            onClicked: () => goToHome(context),
          ),
          bodyWidget: buildImage('assets/s2.png',size.height*0.75),
          decoration: getPageDecoration(),
        ),
      ],
      done: Text("", style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () => goToHome(context),
      showSkipButton: true,
      skip: Text(
        'SKIP',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
      onSkip: () => goToHome(context),
      next: Icon(Icons.forward_outlined, size: 30, color: Colors.grey),
      dotsDecorator: getDotDecoration(),
      onChange: (index) => print('Page $index selected'),
      globalBackgroundColor: Colors.white,
      skipFlex: 0,
      nextFlex: 0,
      isProgressTap: true,
      isProgress: true,
      showNextButton: true,
      // freeze: true,
      animationDuration: 100,

    );}

    void goToHome(context) => Get.offNamed(homeScreen);//Get.offNamed(redirectRoute());

    Widget buildImage(String path,double height) =>
        Align(
            alignment: Alignment.center,
            child: Image.asset(path,height: height,));

    DotsDecorator getDotDecoration() => DotsDecorator(
      color: Colors.black,
      activeColor: Colors.grey,
      size: Size(10, 10),
      activeSize: Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    PageDecoration getPageDecoration() => PageDecoration(
      titleTextStyle: TextStyle(fontSize: 0),
      titlePadding: EdgeInsets.only(top: 0),
      descriptionPadding: EdgeInsets.only(top: 0).copyWith(bottom: 0),
      // imagePadding: EdgeInsets.only(top: 100),
      pageColor: Colors.white,
    );

}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
    onPressed: onClicked,
    color: Colors.grey,
    shape: StadiumBorder(),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    child: Text(text,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}
