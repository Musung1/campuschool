import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Test_WebView extends StatefulWidget {
  const Test_WebView({Key? key}) : super(key: key);

  @override
  State<Test_WebView> createState() => _Test_WebViewState();
}

class _Test_WebViewState extends State<Test_WebView> {
  @override
  Widget build(BuildContext context) {
    JavascriptChannel toasterJavascriptChannel(BuildContext context) {
      return JavascriptChannel(
          name: 'messageHandler',
          onMessageReceived: (JavascriptMessage message) {
            Navigator.pop(context, message.message);
          });
    }
    return Scaffold(
      appBar: AppBar(
        title : Text("WebView")
      ),
      body : WebView(
        initialUrl: 'https://michellehwang001.github.io/study_html_css/javascript/',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          webViewController = webViewController;
        },
        javascriptChannels: <JavascriptChannel>{
          toasterJavascriptChannel(context),
        },
      ),
    );
  }
}