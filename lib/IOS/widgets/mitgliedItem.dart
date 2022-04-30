import 'package:flutter/material.dart';

import '../../classes/Models/mitglied.dart';

class MitgliedItem extends StatelessWidget {
  const MitgliedItem(
      {Key? key,
      required this.padding,
      required this.fontsize,
      required this.mitglied})
      : super(key: key);

  final double padding;
  final double fontsize;
  final Mitglied mitglied;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            //width: double.infinity,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                mitglied.getName,
                style: TextStyle(
                  fontSize: fontsize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
