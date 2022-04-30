import 'package:boeoeg_app/adminInfoWidget.dart';
import 'package:boeoeg_app/classes/Api/mitglied.api.dart';
import 'package:boeoeg_app/classes/Api/terminAbstimmung.api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/Models/mitglied.dart';
import '../../classes/Models/terminAbstimmung.dart';

class AdminView extends StatefulWidget {
  const AdminView({Key? key}) : super(key: key);

  static const routeName = '/adminView';

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  bool isLoading = true;
  bool madeFirst = false;

  List<TerminAbstimmung> kommenList = [];
  List<TerminAbstimmung> abgelehntList = [];
  List<Mitglied> keineAntwort = [];

  @override
  Future<void> load(int id) async {
    if (madeFirst == false) {
      var listAllMitglieder = await MitgliedApi.loadallmitglieder();

      var t =
          await MitgliedApi.loadTerminAbstimmugPersonsByTerminId(terminId: id);

      var listAllZusagen =
          await TerminAbstimmungApi.loadListTerminAbstimmungByTerminId(id);

      //liste der mitglieder die nicht

      var MitgliedNichtDabei = listAllMitglieder
          .where((element) => isMitgliedIn(element, listAllZusagen) == false)
          .toList();

      var zusagenList = listAllZusagen
          .where(
            (element) => element.entscheidung == true,
          )
          .toList();

      kommenList = zusagenList;

      var absagenList = listAllZusagen
          .where(
            (element) => element.entscheidung == false,
          )
          .toList();

      List<Mitglied> keineAktinoList = [];
      for (var mitglied in listAllMitglieder) {
        if (!isMitgliedIn(mitglied, listAllZusagen)) {
          keineAktinoList.add(mitglied);
        }
      }

      abgelehntList = absagenList;
      keineAntwort = keineAktinoList;

      madeFirst = true;

      setState(() {
        isLoading = false;
      });
    }
  }

  bool isMitgliedIn(Mitglied m, List<TerminAbstimmung> liste) {
    bool bo = false;

    liste.forEach((element) {
      if (element.mitglied.id == m.id) {
        bo = true;
      }
    });
    return bo;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as int;

    load(args);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Admin Seite"),
      ),
      child: SafeArea(
          child: AdminInfoWidget(
        id: args,
      )),
    );
  }
}
