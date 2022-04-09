import 'package:boeoeg_app/Android/drawer_widget.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const routeName = "settingsPage";

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Einstellungen"),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: const Drawer_Widget(),
      body: const Center(child: Text("Einstellungen")),
    );
  }
}
