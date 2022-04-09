import 'package:boeoeg_app/classes/Api/mitglied.api.dart';
import 'package:boeoeg_app/classes/Models/mitglied.dart';

import 'package:flutter/material.dart';

import '../../IOS/widgets/mitgliedItem.dart';

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
    print(widget.id);
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
    return Expanded(
      flex: 5,
      child: FutureBuilder<List<Mitglied>>(
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
              return ListView.builder(
                itemCount: projectSnap.data!.length,
                itemBuilder: (context, index) {
                  var item = projectSnap.data as List<Mitglied>;

                  return MitgliedItem(
                    fontsize: 22,
                    padding: 8,
                    mitglied: item[index],
                  );
                },
              );
            }
          }
          return const Text("asdfasdf");
        },
        future: loaddata(),
      ),
    );
  }
}
