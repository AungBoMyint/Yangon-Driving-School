import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../data/constant.dart';
import '../routes/routes.dart';

class Vlog extends StatefulWidget {
  @override
  _VlogState createState() => _VlogState();
}

class _VlogState extends State<Vlog> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.toNamed(homeScreen),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: appBarColor,
        elevation: 0,
        titleSpacing: 5,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                height: 40,
              ),
            Expanded(
              child: Text("  YANGON DRIVING SCHOOL",

                style: TextStyle(
                    overflow: TextOverflow.visible,
                    color: Colors.black,
                    fontSize: 16,
                    wordSpacing: 2,
                    letterSpacing: 2),
              ),
            ),

          ],
        ),
        // centerTitle: true,
      ),
      body: InAppWebView(
        key: webViewKey,
        onEnterFullscreen: (controller) {
          AutoOrientation.landscapeAutoMode();
        },
        initialUrlRequest:
        URLRequest(url: Uri.parse("https://kznpm.com/index.php/ydslearning")),
        initialOptions: options,
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        // onLoadStart: (controller, url) {
        //   setState(() {
        //     this.url = url.toString();
        //     urlController.text = this.url;
        //   });
        // },
        androidOnPermissionRequest: (controller, origin, resources) async {
          return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT);
        },

        onConsoleMessage: (controller, consoleMessage) {
          print(consoleMessage);
        },
      ),
    );
  }
}