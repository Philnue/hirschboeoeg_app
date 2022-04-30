import 'dart:io';

import 'package:flutter/cupertino.dart';

class QrPage extends StatefulWidget {
  const QrPage({Key? key}) : super(key: key);
  static const routeName = '/qrPage';
  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Qr Code"),
        border: Border(
          bottom: BorderSide(
              width: 1,
              color: CupertinoColors.lightBackgroundGray,
              style: BorderStyle.solid),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset("images/insta.PNG"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
