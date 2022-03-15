import 'package:boeoeg_app/classes/httpHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MitgliederView extends StatelessWidget {
  MitgliederView({Key? key, this.id = 0, this.fontsize = 20, this.padding = 8})
      : super(key: key);
  int id;
  double fontsize, padding;
  Future<List<String>> loaddata() async {
    HttpHelper httpHelper = HttpHelper();

    List<String> result;

    if (id == 0) {
      result = await httpHelper.loadallmitglieder();
    } else {
      result =
          await httpHelper.loadTerminAbstimmugPersonsByTerminId(terminId: id);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        builder: (context, AsyncSnapshot projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none) {
            //print('project snapshot data is: ${projectSnap.data}');
            return Text("connection none");
          }
          if (projectSnap.connectionState == ConnectionState.waiting) {
            return Icon(CupertinoIcons.circle);
          }
          return ListView.builder(
            itemCount: projectSnap.data!.length,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          projectSnap.data![index],
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
