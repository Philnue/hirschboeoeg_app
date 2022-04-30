import 'package:boeoeg_app/Android/Widgets/calendar/selectedCalendarItemAndroid.dart';
import 'package:boeoeg_app/classes/constants/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../classes/Models/termin.dart';
import '../../../classes/format.dart';

class CalendarItemAndroid extends StatelessWidget {
  const CalendarItemAndroid({
    Key? key,
    required this.actTermin,
    required this.entscheidung,
  }) : super(key: key);

  final Termin actTermin;
  final int entscheidung;

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
            backgroundColor:
                Format.getAndroidColorsForEntscheidung(entscheidung),
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
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            actTermin.getDateCorrectly.substring(0, 2),
                            //actTermin.getDateCorrectly,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        actTermin.getDateCorrectly,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )),
          ),
          title: Text(
            //Mittler Text Name
            actTermin.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              fontSize: 21,
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
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          onTap: () => Navigator.of(context).pushNamed(
              SelectedCalendarItemAndroid.routeName,
              arguments: actTermin),
          //onLongPress: () {
          //  Navigator.of(context).pushNamed(ContextMenu.routeName);
          //},
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.time,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
              Text(
                actTermin.uhrzeit,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
