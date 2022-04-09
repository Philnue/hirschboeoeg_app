import 'package:boeoeg_app/classes/constants.dart';

import 'package:boeoeg_app/IOS/widgets/calendar/selectedCalendarItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../classes/Models/termin.dart';

class KalendarItem extends StatelessWidget {
  const KalendarItem({Key? key, required this.actTermin}) : super(key: key);

  final Termin actTermin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          tileColor: Colors.white,
          leading: CircleAvatar(
            backgroundColor: CupertinoColors.lightBackgroundGray,
            radius: 30,
            child: Padding(
                //Links Datumsanzeige
                padding: const EdgeInsets.all(3.0),

                //If einbauen wenn des datum heute oder morgen
                child: actTermin.getDateCorrectly.length == 10
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Constants.months[int.parse(actTermin
                                    .getDateCorrectly
                                    .substring(3, 5)) -
                                1],
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: CupertinoColors.darkBackgroundGray),
                          ),
                          Text(
                            actTermin.getDateCorrectly.substring(0, 2),
                            //actTermin.getDateCorrectly,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: CupertinoColors.darkBackgroundGray),
                          ),
                        ],
                      )
                    : Text(
                        actTermin.getDateCorrectly,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.darkBackgroundGray),
                        textAlign: TextAlign.center,
                      )),
          ),
          title: Text(
            //Mittler Text Name
            actTermin.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
              color: CupertinoColors.darkBackgroundGray,
            ),
          ),
          subtitle: SizedBox(
            //Texte unterhalb des Names
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     const Text("Beginn: "),
                //     Text(
                //       actTermin.uhrzeit,
                //     ),
                //     const Text(" Uhr"),
                //   ],
                // ),
                Text(
                  actTermin.treffpunkt,
                  style: (TextStyle(
                      color:
                          CupertinoTheme.of(context).primaryContrastingColor)),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(SelectedCalendarItem.routeName,
                arguments: actTermin);
          },
          //onLongPress: () {
          //  Navigator.of(context).pushNamed(ContextMenu.routeName);
          //},
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
             const Icon(
                CupertinoIcons.time,
                //color: CupertinoTheme.of(context).primaryColor,
                color: CupertinoColors.darkBackgroundGray,
                size: 30,
              ),
              Text(
                actTermin.uhrzeit,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  //color: CupertinoTheme.of(context).primaryColor,
                  color: CupertinoColors.darkBackgroundGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
