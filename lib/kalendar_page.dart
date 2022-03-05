import 'package:boeoeg_app/widgets/kalendaritem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_calendar/cupertino_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:convert' show utf8;
import 'classes/termine.dart';

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

  void transferdata(List<dynamic> list) {
    if (list.isNotEmpty) {
      for (var item in list) {
        allEntries.add(item);

        _termine.addTermin(Termin(
            id: item["id"],
            name: item["name"],
            datum: item["datum"],
            adresse: item["adresse"],
            uhrzeit: item["uhrzeit"].toString(),
            notizen: item["notizen"],
            treffpunkt: item["treffpunkt"],
            kleidung: item["kleidung"]));
      }
    }
  }

  void loadData() async {
    try {
      //Uri dataURL = Uri.parse("http://192.168.178.67:7777/loadalltermine/");
      Uri dataURL = Uri.parse(
          "http://t0orznhg4raqbvfi.myfritz.net:43333/loadalltermine/");

      http.Response response = await http.get(dataURL);

      var data = jsonDecode(response.body);

      setState(() {
        transferdata(data);
      });
    } catch (_) {
      print("API load error" + _.toString());
    }
  }

  String currentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Kalender " + currentDate(),
        ),
        border: Border(
            bottom: BorderSide(
          color: Theme.of(context).dividerColor,
        )),
      ),
      child: ListView.builder(
        itemCount: _termine.orders.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return KalendarItem(actTermin: _termine.orders[index]);
        },
      ),
    );
  }
}
