import 'package:boeoeg_app/classes/Models/abstimmung.dart';
import 'package:boeoeg_app/IOS/widgets/poll/selectedPollItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PollItem extends StatelessWidget {
  const PollItem({Key? key, required this.actAbstimmung}) : super(key: key);

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
          onTap: () {
            Navigator.of(context).pushNamed(SelectedPollItem.routeName,
                arguments: actAbstimmung);
          },
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
                ),
                Text(
                  actAbstimmung.mitglied.fullname,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
