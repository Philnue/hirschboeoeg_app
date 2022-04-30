import 'package:boeoeg_app/Android/Widgets/mitgliedItemGridAndroid.dart';
import 'package:boeoeg_app/Android/Widgets/settings/mitgliedItemAndroid.dart';
import 'package:boeoeg_app/classes/Api/mitglied.api.dart';
import 'package:boeoeg_app/classes/Models/mitglied.dart';

import 'package:flutter/material.dart';

import 'info/aemterListTileAndroid.dart';

class MitgliederViewAndroid extends StatefulWidget {
  const MitgliederViewAndroid(
      {Key? key, this.id = 0, this.fontsize = 20, this.padding = 8})
      : super(key: key);
  final int id;
  final double fontsize, padding;

  @override
  State<MitgliederViewAndroid> createState() => _MitgliederViewAndroidState();
}

class _MitgliederViewAndroidState extends State<MitgliederViewAndroid> {
  bool isloading = true;
  List<Mitglied> _list = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    _list = await MitgliedApi.loadTerminAbstimmugPersonsByTerminId(
        terminId: widget.id);

    setState(() {
      isloading = false;
    });
  }

  Future<List<Mitglied>> loaddata() async {
    List<Mitglied> result;

    if (widget.id == 0) {
      result = await MitgliedApi.loadallmitglieder();
    } else {
      result = await MitgliedApi.loadTerminAbstimmugPersonsByTerminId(
          terminId: widget.id);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Mitglied>>(
      builder: (context, AsyncSnapshot<List<Mitglied>> projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none) {
          return const Text("connection none");
        }
        if (projectSnap.connectionState == ConnectionState.waiting) {
          const CircularProgressIndicator(
            color: Colors.blue,
          );
        } else {
          if (projectSnap.hasData && !projectSnap.hasError) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                ),
                itemCount: projectSnap.data!.length,
                itemBuilder: (context, index) {
                  var item = projectSnap.data as List<Mitglied>;
                  return MitgliedItemGridAndroid(
                    fontsize: 22,
                    padding: 2,
                    mitglied: item[index],
                  );
                });
          }
        }
        return const Text("Loading");
      },
      future: loaddata(),
    );
  }
}



              // ListView.builder(
              //   itemCount: projectSnap.data!.length,
              //   itemBuilder: (context, index) {
              //     var item = projectSnap.data as List<Mitglied>;

              //     return MitgliedItemAndroid(
              //       fontsize: 22,
              //       padding: 8,
              //       mitglied: item[index],
              //     );
              //   },
              // );