import 'package:boeoeg_app/classes/httpHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AllTerminZusagenView extends StatelessWidget {
  const AllTerminZusagenView({Key? key, required this.id}) : super(key: key);

  final int id;
  Future<List<String>> loaddata() async {
    HttpHelper httpHelper = HttpHelper();

    var m = await httpHelper.loadTerminAbstimmugPersonsByTerminId(terminId: id);

    return m;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                padding: const EdgeInsets.all(5.0),
                child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        projectSnap.data![index],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    )),
              ),
            );
          },
        );
      },
      future: loaddata(),
    );
  }
}
