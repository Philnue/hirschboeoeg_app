import 'package:flutter/cupertino.dart';

import '../../../classes/Api/terminAbstimmung.api.dart';

class ShowAcceptedNotAccepted extends StatefulWidget {
  const ShowAcceptedNotAccepted({Key? key, required this.terminId})
      : super(key: key);

  final int terminId;
  @override
  State<ShowAcceptedNotAccepted> createState() =>
      _ShowAcceptedNotAcceptedState();
}

class _ShowAcceptedNotAcceptedState extends State<ShowAcceptedNotAccepted> {
  Map<String, int> map = {};
  double value = 0.0;

  @override
  void initState() {
    // TODO: implement initState

    loadIndicator();
    super.initState();
  }

  Future<void> loadIndicator() async {
    map =
        await TerminAbstimmungApi.getCountsForTermin(terminId: widget.terminId);
    value = map["kommen"]! / map["registrierteMitglieder"]!;
  }

  Future<Map<String, dynamic>> loadTest() async {
    map =
        await TerminAbstimmungApi.getCountsForTermin(terminId: widget.terminId);

    value = map["kommen"]! / map["registrierteMitglieder"]!;
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      builder: (context, AsyncSnapshot<Map<String, dynamic>> projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none) {
          return const Text("connection none");
        }
        if (projectSnap.connectionState == ConnectionState.waiting) {
          const CupertinoActivityIndicator();
        } else {
          if (projectSnap.hasData && !projectSnap.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Angemeldet: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        map["kommen"]!.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Nicht angemeldet: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        (map["registrierteMitglieder"]! - map["kommen"]!)
                            .toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        }
        return const Text("Loading");
      },
      future: loadTest(),
    );
  }
}
