import 'package:boeoeg_app/classes/termine.dart';
import 'package:boeoeg_app/widgets/allTerminZusagen.dart';
import 'package:boeoeg_app/widgets/iconwithtext.dart';
import 'package:boeoeg_app/widgets/notizwidget.dart';
import 'package:boeoeg_app/widgets/futureBuilderSwitch.dart';
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
  int id = 0;

  //HttpHelper httpHelper = HttpHelper();
  //id = Hive.box("settings").get("id");
  //initvalue = httpHelper.getTerminAbstimmungByPersonAndTermin(path: Constants.getTerminAbstimmungByMitgliedAnTermin, terminId: arg.termin_id, mitgliedId: id)

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
              ? NotizWidget(
                  text: args
                      .notizen) //! einbauen mit button zum vergrößern vllt so nen toast boxwie mit namen
              : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Nehme ich teil ?",
                  style: TextStyle(fontSize: 28),
                ),
                FutureBuilderSwitch(actTermin: args),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Liste aller Teilnehmer :",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: AllTerminZusagenView(id: args.id),
          ),
        ],
      )),
    );
  }
}
