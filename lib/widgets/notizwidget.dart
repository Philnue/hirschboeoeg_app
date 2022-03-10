import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NotizWidget extends StatelessWidget {
  const NotizWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.bubble_left,
                  size: 35,
                ),
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: Text(
                    text,
                    maxLines: 4,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
