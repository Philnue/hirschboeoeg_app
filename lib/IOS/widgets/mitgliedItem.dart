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
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                mitglied.spitzName == ""
                    ? mitglied.fullname
                    : mitglied.spitzName,
                style: TextStyle(
                  fontSize: fontsize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )),
      ),
    );
  }
}
