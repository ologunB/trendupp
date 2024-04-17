import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({required this.url});

  final String url;

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  bool isLoading = true;

  late WebViewController controller;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            isLoading = progress != 100;
            setState(() {});
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            Uri uri = Uri.parse(request.url);
            if (uri.queryParameters['status'] == 'cancelled') {
              Navigator.pop(context, [false, 'Payment has been cancelled']);
              return NavigationDecision.navigate;
            } else if (uri.queryParameters['status'] == 'successful') {
              Navigator.pop(context, [true, 'Payment was been successful']);
              return NavigationDecision.navigate;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(_) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.black),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (isLoading)
            LinearProgressIndicator(
              color: AppColors.red,
              backgroundColor: AppColors.lightRed,
            ),
          Expanded(
              child: SafeArea(child: WebViewWidget(controller: controller))),
        ],
      ),
    );
  }
}
