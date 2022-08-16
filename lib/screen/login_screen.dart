import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hammies_user/data/constant.dart';
import 'package:hammies_user/routes/routes.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../../controller/home_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              color: Colors.transparent,
              constraints: BoxConstraints(
                maxWidth: 400.0,
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Image.asset(
                      "assets/logo2.png",
                      width: Get.width / 2,
                    ),
                  ),
                  /*Text(
                    "Pos App",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),*/
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    width: Get.width - 100,
                    child: InkWell(
                      onTap: () => homeController.signInWithGoogle(homeScreen),
                      child: Card(
                        color: homeIndicatorColor,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: homeIndicatorColor,
                                radius: 12,
                                child: Icon(
                                  FontAwesomeIcons.google,
                                  color: Colors.yellow,
                                  size: 18,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "Sign in with Google",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                  SizedBox(
                    height: 55,
                    width: 285,
                    child: SignInWithAppleButton(onPressed: ()async {
                      final credentials = await SignInWithApple
                          .getAppleIDCredential(scopes: [
                        AppleIDAuthorizationScopes.email,
                        AppleIDAuthorizationScopes.fullName
                      ]);
                      debugPrint(credentials.email);
                      debugPrint(credentials.state);
                      OAuthProvider oAuthProvider =
                      OAuthProvider("apple.com");
                      final AuthCredential credential = oAuthProvider.credential(
                        idToken:
                        String.fromCharCodes(credentials.identityToken!.codeUnits),
                        accessToken:
                        String.fromCharCodes(credentials.authorizationCode.codeUnits),
                      );
                      await FirebaseAuth.instance.signInWithCredential(credential).then((value) => {
                      Get.offNamed(homeScreen),
                      });
                    }),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
