import 'package:flutter/material.dart';

import '../../classes/Api/mitglied.api.dart';
import '../../classes/format.dart';
import '../../classes/hiveHelper.dart';

class AndroidTextField extends StatefulWidget {
  const AndroidTextField(
      {Key? key,
      required this.title,
      required this.func,
      required this.initValue})
      : super(key: key);

  final String title;
  final String initValue;
  final Function func;

  @override
  State<AndroidTextField> createState() => _AndroidTextFieldState();
}

class _AndroidTextFieldState extends State<AndroidTextField> {
  late TextEditingController _controller = TextEditingController(text: "");
  final int _id = HiveHelper.currentId;
  //! teste

  void showAlertDialog(String title, String description) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.initValue);
    //! vllt wieder rein
    //_id = HiveHelper.currentId;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Format.isAcceptTime == true
            ? Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )
            : const Text(
                "Saufmodus ist aktiviert",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 20,
                ),
              ),
        TextField(
          enabled: Format.isAcceptTime,
          controller: _controller,
          onSubmitted: (value) {
            setState(() {
              _controller.text = value;
              widget.func(value);
            });
          },
        ),
      ],
    );
  }
}
