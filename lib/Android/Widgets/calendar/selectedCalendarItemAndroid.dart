import 'package:boeoeg_app/Android/Widgets/mitgliederViewAndroid.dart';
import 'package:boeoeg_app/classes/Models/termin.dart';
import 'package:boeoeg_app/IOS/widgets/calendar/cupertinoActionSheetCustom.dart';
import 'package:boeoeg_app/IOS/widgets/calendar/notizwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../classes/Api/terminAbstimmung.api.dart';

class SelectedCalendarItemAndroid extends StatefulWidget {
  const SelectedCalendarItemAndroid({Key? key}) : super(key: key);

  static const routeName = "selectedCalendarItemAndroid";

  @override
  State<SelectedCalendarItemAndroid> createState() =>
      _SelectedCalendarItemAndroidState();
}

class _SelectedCalendarItemAndroidState
    extends State<SelectedCalendarItemAndroid> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var m = MediaQuery.of(context).size;
    int _mitgliedid = Hive.box("settings").get("id");
    final Termin args = ModalRoute.of(context)!.settings.arguments as Termin;

    _addTerminAbstimung() {
      TerminAbstimmungApi.addTerminAbstimmung(
        terminId: args.id,
        mitgliedId: _mitgliedid,
        entscheidung: 1,
      );
    }

    _deleteTerminAbstimmung() {
      TerminAbstimmungApi.deleteTerminAbstimmung(
          terminId: args.id, mitgliedId: _mitgliedid);
    }

    var stringListe = [
      {args.uhrzeit, Icons.watch_later, "Uhrzeit:     "},
      {args.datumConvertedInGerman, Icons.calendar_month, "Datum:      "},
      {args.adresse, Icons.place, "Adresse:    "},
      {args.treffpunkt, Icons.pin, "Treffpunkt:"},
      {args.kleidung, Icons.cases_outlined, "Kleidung:   "},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          args.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: stringListe.length,
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(
                            stringListe[index].elementAt(1) as IconData,
                            size: 30),
                        //icon: stringListe[index].elementAt(1) as IconData,

                        title: Text(
                          stringListe[index].elementAt(2) as String,
                          style: const TextStyle(fontSize: 22),
                        ),

                        trailing: Text(
                          stringListe[index].elementAt(0) as String,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  );
                })),
            args.notizen.length > 1
                ? NotizWidget(text: args.notizen)
                : Container(),
            FlatButton(
              padding: const EdgeInsets.all(10),
              color: CupertinoColors.systemBlue,
              child: Container(
                child: const Text(
                  "Entscheidung abgeben",
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => const CupertinoActionSheetCustom(),
                ).then((value) {
                  if (value == "add") {
                    if (_mitgliedid != 0) {
                      _addTerminAbstimung();
                      refresh();
                    }
                  }
                  if (value == "delete") {
                    if (_mitgliedid != 0) {
                      _deleteTerminAbstimmung();
                      refresh();
                    }
                  }
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Liste aller Zusagen:",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //SwitchTest(actTermin: args),

            MitgliederViewAndroid(
              id: args.id,
            )
            //FutureBuilderSwitchWithList(actTermin: args),
          ],
        ),
      )),
    );
  }
}
