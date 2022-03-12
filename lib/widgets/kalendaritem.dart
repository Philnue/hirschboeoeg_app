import 'package:boeoeg_app/widgets/aemter.dart';
import 'package:boeoeg_app/widgets/selectedCalendarItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../classes/termine.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class KalendarItem extends StatelessWidget {
  const KalendarItem({Key? key, required this.actTermin}) : super(key: key);

  final Termin actTermin;

  String currentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    List months = [
      'Jan',
      'Feb',
      'Mrz',
      'Apr',
      'Mai',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Okt',
      'Nov',
      'Dez'
    ];
    return Card(
      child: ListTile(
        tileColor: Colors.white,
        leading: Padding(
            //Links Datumsanzeige
            padding: const EdgeInsets.all(3.0),

            //If einbauen wenn des datum heute oder morgen
            child: actTermin.getDateCorrectly.length == 10
                ? Column(
                    children: [
                      Text(
                        months[int.parse(
                                actTermin.getDateCorrectly.substring(3, 5)) -
                            1],
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        actTermin.getDateCorrectly.substring(0, 2),
                        //actTermin.getDateCorrectly,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  )
                : Text(
                    actTermin.getDateCorrectly,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
        title: Text(
          //Mittler Text Name
          actTermin.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        subtitle: SizedBox(
          //Texte unterhalb des Names
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Beginn: "),
                  Text(
                    actTermin.uhrzeit,
                  ),
                  const Text(" Uhr"),
                ],
              ),
              Text(
                actTermin.treffpunkt,
              ),
            ],
          ),
        ),
        trailing: IconButton(
          //Icon Button Info
          icon: const Icon(
            CupertinoIcons.info_circle_fill,
            size: 30,
          ),
          onPressed: () {
            //Navigator.of(context).pushNamed(SelectedCalendarItem.routeName,                arguments: actTermin);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SelectedCalendarItem(
                        termin: actTermin,
                      )),
            );
          },
        ),
      ),
    );
  }
}
