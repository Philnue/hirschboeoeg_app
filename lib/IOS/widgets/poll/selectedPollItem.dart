import 'package:boeoeg_app/classes/Models/abstimmung.dart';
import 'package:flutter/cupertino.dart';
import '../calendar/cupertinoListTile.dart';

class SelectedPollItem extends StatefulWidget {
  const SelectedPollItem({Key? key}) : super(key: key);
  static const routeName = '/selectedPollItem';

  @override
  State<SelectedPollItem> createState() => _SelectedPollItemState();
}

class _SelectedPollItemState extends State<SelectedPollItem> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Abstimmung;

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text(args.titel)),
        child: SafeArea(
          child: Column(
            children: [
              CupertinoListTile(
                title: "Ersteller: ",
                leading: CupertinoIcons.person,
                trailing: args.mitglied.fullname,
              ),
              CupertinoListTile(
                title: "Erstellungdatum: ",
                leading: CupertinoIcons.calendar,
                trailing: args.erstellungsDatumConverted,
              ),
              CupertinoListTile(
                title: "Ablaufdatum: ",
                leading: CupertinoIcons.calendar,
                trailing: args.ablaufDatumConverted,
              ),
              CupertinoListTile(
                title: "Titel: ",
                leading: CupertinoIcons.squares_below_rectangle,
                trailing: args.titel,
              ),
              CupertinoListTile(
                title: "Frage: ",
                leading: CupertinoIcons.question,
                trailing: args.frage,
              ),
              Text(args.frage)
            ],
          ),
        ));
  }
}


//halflasdlfa
//dfalöksdjföalsdf
//adflökajsödlfjöalsdf
//asdfölakjdöflajd, lkajösldjkfasd
//fdasda