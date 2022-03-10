import 'dart:convert';

import 'package:boeoeg_app/classes/termine.dart';
import 'package:boeoeg_app/widgets/iconwithtext.dart';
import 'package:boeoeg_app/widgets/notizwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedCalendarItem extends StatefulWidget {
  const SelectedCalendarItem({Key? key}) : super(key: key);
  static const routeName = '/selectedCalendarItem';

  @override
  State<SelectedCalendarItem> createState() => _SelectedCalendarItemState();
}

class _SelectedCalendarItemState extends State<SelectedCalendarItem> {
  bool initvalue = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Termin;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          args.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconWithText(
            icon: CupertinoIcons.clock,
            width: 15,
            text: args.uhrzeit,
            textSize: 30,
          ),
          IconWithText(
            icon: CupertinoIcons.calendar,
            width: 15,
            text: args.datumConvertedInGerman,
            textSize: 30,
          ),
          IconWithText(
            icon: CupertinoIcons.placemark,
            width: 15,
            text: args.treffpunkt,
            textSize: 30,
          ),
          IconWithText(
            icon: CupertinoIcons.briefcase,
            width: 15,
            text: args.kleidung,
            textSize: 30,
          ),
          IconWithText(
            icon: CupertinoIcons.placemark_fill,
            width: 15,
            text: args.adresse,
            textSize: 30,
          ),
          args.notizen.length > 1
              ? NotizWidget(text: args.notizen)
              : Container(),
          Row(
            children: [
              const Text(
                "Nehme ich teil ?",
                style: TextStyle(fontSize: 28),
              ),
              CupertinoSwitch(
                  value: initvalue,
                  onChanged: (value) => {
                        setState(() {
                          initvalue = value;
                        })
                      }),
            ],
          ),
          Text("Liste allter Teilnahmen")
        ],
      )),
    );
  }
}
