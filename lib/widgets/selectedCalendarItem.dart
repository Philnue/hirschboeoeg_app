import 'dart:convert';

import 'package:boeoeg_app/classes/constants.dart';
import 'package:boeoeg_app/classes/httpHelper.dart';
import 'package:boeoeg_app/classes/termine.dart';
import 'package:boeoeg_app/widgets/iconwithtext.dart';
import 'package:boeoeg_app/widgets/notizwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SelectedCalendarItem extends StatefulWidget {
  const SelectedCalendarItem({Key? key, required this.termin})
      : super(key: key);
  static const routeName = '/selectedCalendarItem';
  final Termin termin;
  @override
  State<SelectedCalendarItem> createState() => _SelectedCalendarItemState();
}

class _SelectedCalendarItemState extends State<SelectedCalendarItem> {
  bool initvalue = false;
  int id = 0;

  //HttpHelper httpHelper = HttpHelper();
  //id = Hive.box("settings").get("id");
  //initvalue = httpHelper.getTerminAbstimmungByPersonAndTermin(path: Constants.getTerminAbstimmungByMitgliedAnTermin, terminId: arg.termin_id, mitgliedId: id)

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Termin;

    Future<bool> test() async {
      HttpHelper tt = HttpHelper();
      id = Hive.box("settings").get("id");
      var m = await tt.getTerminAbstimmungByPersonAndTermin(
        path: Constants.getTerminAbstimmungByMitgliedAnTermin,
        terminId: args.id,
        mitgliedId: id,
      );

      return m;
    }

    bool test2() {
      var t = test();

      return test();
    }

    HttpHelper httpHelper = HttpHelper();
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
                  value: httpHelper.getTerminAbstimmungByPersonAndTermin(
                      path: Constants.getTerminAbstimmungByMitgliedAnTermin,
                      terminId: args.id,
                      mitgliedId: id) as bool,
                  onChanged: (value) => {
                        setState(() {
                          initvalue = value;
                          int id = Hive.box("settings").get("id");

                          HttpHelper httpHelper = HttpHelper();
                          var m =
                              httpHelper.getTerminAbstimmungByPersonAndTermin(
                                  path: Constants
                                      .getTerminAbstimmungByMitgliedAnTermin,
                                  terminId: args.id,
                                  mitgliedId: id);

                          httpHelper.addTerminAbstimmung(
                              path: Constants.addTerminAbstimmung,
                              terminId: args.id,
                              mitgliedId: id,
                              entscheidung: value);
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
