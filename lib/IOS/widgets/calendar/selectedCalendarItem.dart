import 'package:boeoeg_app/classes/Models/termin.dart';
import 'package:boeoeg_app/IOS/widgets/calendar/cupertinoActionSheetCustom.dart';
import 'package:boeoeg_app/IOS/widgets/calendar/cupertinoListTile.dart';
import 'package:boeoeg_app/IOS/widgets/mitgliederView.dart';
import 'package:boeoeg_app/IOS/widgets/calendar/notizwidget.dart';
import 'package:boeoeg_app/classes/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../classes/Api/terminAbstimmung.api.dart';

class SelectedCalendarItem extends StatefulWidget {
  const SelectedCalendarItem({Key? key}) : super(key: key);
  static const routeName = '/selectedCalendarItem';

  @override
  State<SelectedCalendarItem> createState() => _SelectedCalendarItemState();
}

class _SelectedCalendarItemState extends State<SelectedCalendarItem> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var m = MediaQuery.of(context).size;
    int _mitgliedid = Hive.box("settings").get("id");
    final args = ModalRoute.of(context)!.settings.arguments as Termin;

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
      {args.uhrzeit, CupertinoIcons.clock, "Uhrzeit:     "},
      {args.datumConvertedInGerman, CupertinoIcons.calendar, "Datum:      "},
      {args.adresse, CupertinoIcons.placemark_fill, "Adresse:    "},
      {args.treffpunkt, CupertinoIcons.pin, "Treffpunkt:"},
      {args.kleidung, CupertinoIcons.briefcase, "Kleidung:   "},
    ];

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
          child: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.end,
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
            CupertinoButton(
              padding: const EdgeInsets.all(10),
              disabledColor: CupertinoColors.systemRed,
              color: CupertinoColors.systemBlue,
              child: Container(
                child: Format.isAcceptTime
                    ? const Text(
                        "Entscheidung abgeben",
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Text("Saufmodus aktiviert"),
              ),
              onPressed: Format.isAcceptTime == true
                  ? () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) =>
                            const CupertinoActionSheetCustom(),
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

            MitgliederView(
              id: args.id,
            )
            //FutureBuilderSwitchWithList(actTermin: args),
          ],
        ),
      )),
    );
  }
}
