import 'package:boeoeg_app/classes/Models/abstimmung.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PollItemAndroid extends StatelessWidget {
  const PollItemAndroid({Key? key, required this.actAbstimmung})
      : super(key: key);

  final Abstimmung actAbstimmung;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          tileColor: Colors.white,
          leading: Padding(
            //Links Datumsanzeige
            padding: const EdgeInsets.all(3.0),

            //If einbauen wenn des datum heute oder morgen
            child: Text(
              actAbstimmung.ablaufDatumConverted.substring(0, 5),
              style: TextStyle(
                color: CupertinoTheme.of(context).primaryContrastingColor,
              ),
            ),
          ),
          title: Text(
            //Mittler Text Name
            actAbstimmung.titel.length > 15
                ? actAbstimmung.titel.substring(0, 15)
                : actAbstimmung.titel,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          subtitle: SizedBox(
            //Texte unterhalb des Names
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  actAbstimmung.erstellungsDatumConverted,
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  actAbstimmung.mitglied.fullname,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          trailing: IconButton(
            //Icon Button Info
            icon: const Icon(
              CupertinoIcons.info,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              //Navigator.of(context).pushNamed(SelectedPollItem.routeName,                  arguments: actAbstimmung);
            },
          ),
        ),
      ),
    );
  }
}
