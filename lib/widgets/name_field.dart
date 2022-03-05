import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NamefieldWidget extends StatefulWidget {
  const NamefieldWidget({Key? key}) : super(key: key);

  @override
  _NamefieldWidgetState createState() => _NamefieldWidgetState();
}

class _NamefieldWidgetState extends State<NamefieldWidget> {
  late TextEditingController _textController;
  late Box<dynamic> _box;

  @override
  void initState() {
    super.initState();

    _box = Hive.box("settings");
    //_textController =        TextEditingController(text: hiveHelper.loadDataString("name"));
    _textController = TextEditingController(text: _box.get("name"));
  }

  void setNameToHive(String name) {}

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: _textController,
      keyboardType: TextInputType.text,
      placeholder: "Name",
      decoration: BoxDecoration(
          border: Border.all(
        width: 0.5,
        color: CupertinoColors.white,
      )),
      onSubmitted: (value) {
        setState(() {
          _textController.text = value;
          _box.put("name", value);
          print(value);
        });
      },
      prefix: Icon(CupertinoIcons.person),
    );
  }
}
