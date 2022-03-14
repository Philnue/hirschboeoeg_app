import 'package:boeoeg_app/classes/format.dart';
import 'package:boeoeg_app/classes/httpHelper.dart';
import 'package:boeoeg_app/widgets/kalendaritem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'classes/termine.dart';
import 'classes/constants.dart' as consts;

class KalendarClass extends StatefulWidget {
  const KalendarClass({Key? key}) : super(key: key);

  @override
  _KalendarClassState createState() => _KalendarClassState();
}

class _KalendarClassState extends State<KalendarClass> {
  List<dynamic> allEntries = [];
  var _termine = Termine();
  @override
  void initState() {
    super.initState();

    loadData();
  }

  void transferdata(List<Termin> list) {
    if (list.isNotEmpty) {
      for (var item in list) {
        allEntries.add(item);

        _termine.addTermin(item);
      }
    }
  }

  void loadData() async {
    try {
      HttpHelper httpHelper = HttpHelper();
      var data =
          await httpHelper.loadAllTermine(consts.Constants.loadAllTermine);

      setState(() {
        transferdata(data);
      });
    } catch (_) {
      print("API load error " + _.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Kalender " + Format.currentDate(),
        ),
        border: Border(
            bottom: BorderSide(
          color: Theme.of(context).dividerColor,
        )),
      ),
      child: _termine.orders.isNotEmpty
          ? ListView.builder(
              itemCount: _termine.orders.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return KalendarItem(actTermin: _termine.orders[index]);
              },
            )
          : const Center(child: Text("Bitte Internetverbindung überprüfen")),
    );
  }
}
