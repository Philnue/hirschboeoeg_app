import 'package:boeoeg_app/IOS/widgets/mitgliedItem.dart';
import 'package:boeoeg_app/classes/Api/mitglied.api.dart';
import 'package:boeoeg_app/classes/Models/mitglied.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

class MitgliederView extends StatelessWidget {
  MitgliederView({Key? key, this.id = 0, this.fontsize = 20, this.padding = 8})
      : super(key: key);
  int id;
  double fontsize, padding;

  Future<List<Mitglied>> loaddata() async {

    List<Mitglied> result;

    if (id == 0) {
      result = await MitgliedApi.loadallmitglieder();
    } else {
      result =
          await MitgliedApi.loadTerminAbstimmugPersonsByTerminId(terminId: id);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var t = Platform.isAndroid;

    return FutureBuilder<List<Mitglied>>(
      builder: (context, AsyncSnapshot<List<Mitglied>> projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none) {
          return const Text("connection none");
        }
        if (projectSnap.connectionState == ConnectionState.waiting) {
          return t
              ? const CircularProgressIndicator(
                  color: Colors.blue,
                )
              : const CupertinoActivityIndicator();
        }
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
            ),
            itemCount: projectSnap.data!.length,
            itemBuilder: (context, index) {
              var item = projectSnap.data as List<Mitglied>;
              return MitgliedItem(
                fontsize: 22,
                padding: 2,
                mitglied: item[index],
              );
            });
      },
      future: loaddata(),
    );
  }
}
