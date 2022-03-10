import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AemterText extends StatelessWidget {
  const AemterText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
    );
  }
}
