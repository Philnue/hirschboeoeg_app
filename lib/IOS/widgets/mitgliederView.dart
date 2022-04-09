import 'package:boeoeg_app/classes/Api/mitglied.api.dart';
import 'package:boeoeg_app/classes/Models/mitglied.dart';
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

    return Expanded(
      flex: 5,
      child: FutureBuilder<List<Mitglied>>(
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
          return ListView.builder(
            itemCount: projectSnap.data!.length,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          projectSnap.data![index].fullname,
                          style: TextStyle(
                              fontSize: fontsize, fontWeight: FontWeight.w600),
                        ),
                      )),
                ),
              );
            },
          );
        },
        future: loaddata(),
      ),
    );
  }
}
