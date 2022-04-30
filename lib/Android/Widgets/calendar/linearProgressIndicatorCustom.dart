import 'package:boeoeg_app/classes/Api/terminAbstimmung.api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:device_calendar/device_calendar.dart';

class LinearProgressIndicatorCustom extends StatefulWidget {
  const LinearProgressIndicatorCustom({Key? key, required this.terminId})
      : super(key: key);

  final int terminId;

  @override
  State<LinearProgressIndicatorCustom> createState() =>
      _LinearProgressIndicatorCustomState();
}

class _LinearProgressIndicatorCustomState
    extends State<LinearProgressIndicatorCustom> {
  Map<String, int> map = {};
  double value = 0.0;
  @override
  void initState() {
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
          const CircularProgressIndicator(
            color: Colors.blue,
          );
        } else {
          if (projectSnap.hasData && !projectSnap.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
              child: Row(
                children: [
                  Text(
                    map["kommen"]!.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: LinearProgressIndicator(
                      backgroundColor:
                          CupertinoColors.systemRed.withOpacity(0.7),
                      valueColor: AlwaysStoppedAnimation<Color>(
                          CupertinoColors.activeGreen.withOpacity(0.7)),
                      value: value,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    (map["registrierteMitglieder"]! - map["kommen"]!)
                        .toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
