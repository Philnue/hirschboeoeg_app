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
    return Card(
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            actTermin.getDateCorrectly,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          actTermin.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Treffpunkt: "),
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
          icon: Icon(CupertinoIcons.info_circle_fill),
          onPressed: () {
            Navigator.of(context).pushNamed(SelectedCalendarItem.routeName,
                arguments: actTermin);
          },
        ),
      ),
    );
  }
}
