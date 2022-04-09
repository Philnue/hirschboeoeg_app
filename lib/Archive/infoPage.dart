import 'package:boeoeg_app/IOS/widgets/info/aemterWidget.dart';
import 'package:boeoeg_app/IOS/widgets/mitgliederView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: true,
        navigationBar: CupertinoNavigationBar(
          middle: const Text("Info Seite"),
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const AemterWidget(),
              const Text("Alle Mitglieder"),
              MitgliederView(
                fontsize: 15,
                padding: 3,
              ),
            ],
          ),
        ));
  }
}
