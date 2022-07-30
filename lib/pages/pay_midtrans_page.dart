import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../theme.dart';

class PayMidtransPage extends StatefulWidget {
  String? url;
  PayMidtransPage({Key? key, this.url}) : super(key: key);

  @override
  State<PayMidtransPage> createState() => _PayMidtransPageState();
}

class _PayMidtransPageState extends State<PayMidtransPage> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pembayaran"),
        leading: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: "${widget.url}",
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
      ),
    );
  }
}
