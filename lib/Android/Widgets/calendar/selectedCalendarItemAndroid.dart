import 'package:boeoeg_app/Android/AndroidAlertDialogCustom.dart';
import 'package:boeoeg_app/Android/Pages/adminView.dart';
import 'package:boeoeg_app/Android/Widgets/calendar/linearProgressIndicatorCustom.dart';
import 'package:boeoeg_app/Android/Widgets/mitgliederViewAndroid.dart';
import 'package:boeoeg_app/IOS/Pages/settingsPage.dart';
import 'package:boeoeg_app/IOS/widgets/calendar/cupertinoListTile.dart';
import 'package:boeoeg_app/classes/Models/termin.dart';
import 'package:boeoeg_app/IOS/widgets/calendar/cupertinoActionSheetCustom.dart';
import 'package:boeoeg_app/IOS/widgets/calendar/notizwidget.dart';
import 'package:boeoeg_app/classes/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../classes/Api/terminAbstimmung.api.dart';
import '../../../classes/calendarHelper.dart';
import '../../../classes/format.dart';
import '../../../classes/hiveHelper.dart';

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
        centerTitle: true,
        title: Text(
          args.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        actions: [
          Constants.isAdmin
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AdminView.routeName, arguments: args.id);
                  },
                  icon: Icon(Icons.info),
                )
              : Text(""),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: stringListe.length,
                itemBuilder: ((context, index) {
                  return CupertinoListTile(
                    leading: stringListe[index].elementAt(1) as IconData,
                    //icon: stringListe[index].elementAt(1) as IconData,

                    title: stringListe[index].elementAt(2) as String,
                    trailing: stringListe[index].elementAt(0) as String,
                  );
                })),
            args.notizen.length > 1
                ? NotizWidget(text: args.notizen)
                : Container(),
            ElevatedButton(
              // padding: const EdgeInsets.all(10),
              // color: CupertinoColors.systemBlue,

              child: Container(
                child: const Text(
                  "Entscheidung abgeben",
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: Hive.box("settings").get("saufiAktiviert") == false
                  ? () {
                      if (HiveHelper.isIdSet) {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) =>
                              const CupertinoActionSheetCustom(),
                        ).then((value) async {
                          await TerminAbstimmungApi.addOrUpdateTerminAbstimmung(
                              value, args);

                          if (value == "delete") {
                            //delete Termin

                            var allCalendars = await CalendarHelper()
                                .lookAllCalendarsForTheEntrie(args);
                          }

                          if (value == "add") {
                            var m = await CalendarHelper().loadAllCalendars();

                            if (m != null && m.isNotEmpty) {
                              List<Widget> actions = [];
                              m.forEach((element) {
                                if (element.name != null) {
                                  actions.add(
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, element.id);
                                      },
                                      child: Text("${element.name}"),
                                    ),
                                  );
                                }
                              });
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) => CupertinoActionSheet(
                                  title: const Text("Welcher Kalender"),
                                  message: const Text("Kalender auswählen"),
                                  actions: actions,
                                  cancelButton: CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(context, "cancel");
                                    },
                                    child: const Text("Abbrechen"),
                                    isDefaultAction: true,
                                  ),
                                ),
                              ).then((value) async {
                                //! wtesten nur wen even sto
                                await CalendarHelper().addEvent(args, value);
                              });
                            }
                          }

                          refresh();
                        });
                      } else {
                        AndroidAlertDialogCustom.showAlertDialog(
                          "Fehler",
                          "Bevor sie eine Terminabstimmung abgeben können, müssen sie erst einen Namen definieren",
                          context,
                          [
                            TextButton(
                              child: Text("Ok"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text("Einstellungen"),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(SettingsPage.routeName);
                              },
                            )
                          ],
                        );
                        //name muss gesetzt werden
                      }
                    }
                  : null,
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
            LinearProgressIndicatorCustom(terminId: args.id),

            Expanded(
              child: MitgliederViewAndroid(
                id: args.id,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
