import 'package:boeoeg_app/classes/termine.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../classes/constants.dart';
import '../classes/httpHelper.dart';

class FutureBuilderSwitch extends StatefulWidget {
  const FutureBuilderSwitch({Key? key, required this.actTermin})
      : super(key: key);
  final Termin actTermin;

  @override
  State<FutureBuilderSwitch> createState() => _FutureBuilderSwitchState();
}

class _FutureBuilderSwitchState extends State<FutureBuilderSwitch> {
  int id = 0;
  bool isalreadyin = false;
  bool initvalue = false;

  Future<bool> loadCurrentDecisionAsFuture() async {
    HttpHelper tt = HttpHelper();

    id = Hive.box("settings").get("id");
    var m = await tt.getTerminAbstimmungByPersonAndTermin(
      terminId: widget.actTermin.id,
      mitgliedId: id,
    );

    //!hie rrein mi tisalready in überprüfen

    return m;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: loadCurrentDecisionAsFuture(),
        builder: (BuildContext context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text("Geht nicth");
            case ConnectionState.waiting:
              return const Icon(CupertinoIcons.circle);
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                isalreadyin = snapshot.data as bool;
              return CupertinoSwitch(
                  value: isalreadyin,
                  onChanged: (value) {
                    setState(() {
                      isalreadyin = value;
                      HttpHelper httpHelper = HttpHelper();
                      if (value == true) {
                        //
                        httpHelper.addTerminAbstimmung(
                          terminId: widget.actTermin.id,
                          mitgliedId: Hive.box("settings").get("id"),
                          entscheidung: 1,
                        );
                      }

                      if (value == false) {
                        //
                        httpHelper.deleteTerminAbstimmung(
                            terminId: widget.actTermin.id,
                            mitgliedId: Hive.box("settings").get("id"));
                      }

                      Navigator.of(context).pop();
                    });
                    //! value change und hinzufügen oder löschen aus der db
                  });
          }
        });
  }
}
