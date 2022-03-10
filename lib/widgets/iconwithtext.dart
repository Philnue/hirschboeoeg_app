import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  const IconWithText(
      {Key? key,
      required this.icon,
      required this.width,
      required this.text,
      required this.textSize})
      : super(key: key);

  final IconData icon;
  final double width, textSize;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Row(
        children: [
          Icon(
            icon,
            size: 35,
          ),
          SizedBox(
            width: width,
          ),
          Text(
            text,
            style: TextStyle(fontSize: textSize),
          ),
        ],
      ),
    );
  }
}
