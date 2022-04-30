import 'package:boeoeg_app/Android/Widgets/info/aemterWidgetAndroid.dart';
import 'package:boeoeg_app/Android/Widgets/mitgliederViewAndroid.dart';
import 'package:boeoeg_app/Android/drawerWidget.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  static const routeName = "infoPage";

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info Seite"),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: Column(
          children: const [
            Flexible(
              flex: 5,
              child: AemterWidgetAndroid(),
            ),
            Flexible(
              flex: 1,
              child: Text(
                "Böögs",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            Expanded(
              flex: 5,
              child: MitgliederViewAndroid(),
            ),
          ],
        ),
      ),
    );
  }
}
