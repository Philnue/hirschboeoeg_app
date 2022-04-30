import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'classes/Api/mitglied.api.dart';
import 'classes/Api/terminAbstimmung.api.dart';
import 'classes/Models/mitglied.dart';
import 'classes/Models/terminAbstimmung.dart';

class AdminInfoWidget extends StatefulWidget {
  const AdminInfoWidget({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<AdminInfoWidget> createState() => _AdminInfoWidgetState();
}

class _AdminInfoWidgetState extends State<AdminInfoWidget> {
  bool isLoading = true;
  bool madeFirst = false;

  List<TerminAbstimmung> kommenList = [];
  List<TerminAbstimmung> abgelehntList = [];
  List<Mitglied> keineAntwort = [];

  @override
  void initState() {
    // TODO: implement initState
    load(widget.id);
    super.initState();
  }

  Future<void> load(int id) async {
    if (madeFirst == false) {
      var listAllMitglieder = await MitgliedApi.loadallmitglieder();

      var listAllZusagen =
          await TerminAbstimmungApi.loadListTerminAbstimmungByTerminId(id);

      //liste der mitglieder die nicht

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
    return isLoading
        ? const CircularProgressIndicator(
            color: Colors.blue,
          )
        : Column(
            children: [
              Text(
                "Kommen: ${kommenList.length}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5,
                  ),
                  itemCount: kommenList.length,
                  itemBuilder: (context, index) {
                    return Text(kommenList[index].mitglied.getName);
                  },
                ),
              ),
              abgelehntList.isNotEmpty
                  ? Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Kommen nicht: ${abgelehntList.length}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 5,
                              ),
                              itemCount: abgelehntList.length,
                              itemBuilder: (context, index) {
                                return Text(
                                    abgelehntList[index].mitglied.getName);
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text(
                      "Es hat sich keiner abgemeldet",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              Text(
                "Keine Aktion: ${keineAntwort.length}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5,
                  ),
                  itemCount: keineAntwort.length,
                  itemBuilder: (context, index) {
                    return Text(keineAntwort[index].getName);
                  },
                ),
              )
            ],
          );
  }
}
