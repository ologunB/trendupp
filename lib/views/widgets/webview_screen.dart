import 'package:flutter/material.dart';
import 'package:mms_app/app/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:mms_app/views/widgets/text_widgets.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({required this.title, required this.url});

  final String title;
  final String url;

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  bool isLoading = true;

  @override
  Widget build(_) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 0,
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
          leading: SizedBox(),
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/logo2.png', height: 32.h),
                Spacer(),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            if (isLoading)
              LinearProgressIndicator(
                color: AppColors.red,
                backgroundColor: AppColors.lightRed,
              ),
            Expanded(
              child: SafeArea(
                child: WebView(
                  initialUrl: widget.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onProgress: (a) {
                    isLoading = a != 100;
                    setState(() {});
                  },
                  navigationDelegate: (NavigationRequest request) {
                    Uri uri = Uri.parse(request.url);
                    if (uri.queryParameters['status'] == 'cancelled') {
                      Navigator.pop(
                          context, [false, 'Payment has been cancelled']);
                      return NavigationDecision.navigate;
                    } else if (uri.queryParameters['status'] == 'successful') {
                      Navigator.pop(
                          context, [true, 'Payment was been successful']);
                      return NavigationDecision.navigate;
                    } else {
                      Navigator.pop(context, [false, 'An error has occurred']);
                      return NavigationDecision.navigate;
                    }
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
