import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebDetail extends StatelessWidget {
 final String link;

 WebDetail(this.link);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: WebView(
                  initialUrl: link,
                  javascriptMode: JavascriptMode.unrestricted,
                  onProgress: (val){

                  },
                ),
              )
            ],
          ),
        ));
  }
}
