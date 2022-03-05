import 'package:boeoeg_app/classes/termine.dart';
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
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Termin;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(args.name),
        trailing: Text(args.datumConvertedInGerman),
      ),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.placemark,
                size: 30,
              ),
              Text(
                args.treffpunkt,
                style: TextStyle(fontSize: 28),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                CupertinoIcons.briefcase,
                size: 30,
              ),
              Text(
                args.kleidung,
                style: TextStyle(fontSize: 28),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                CupertinoIcons.placemark_fill,
                size: 30,
              ),
              Text(
                args.adresse,
                style: TextStyle(fontSize: 28),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                CupertinoIcons.text_justify,
                size: 30,
              ),
              Text(
                args.notizen,
                style: TextStyle(fontSize: 28),
              ),
            ],
          ),
          Row(
            children: [
              Text("Nehme ich teil ?"),
              CupertinoSwitch(
                  value: initvalue,
                  onChanged: (value) => {
                        setState(() {
                          initvalue = value;
                        })
                      }),
            ],
          ),
          Text("Liste allter Teilnahmen")
        ]),
      ),
    );
  }
}
