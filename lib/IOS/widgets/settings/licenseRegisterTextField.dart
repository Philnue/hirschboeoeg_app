import 'package:boeoeg_app/classes/hiveHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../classes/Api/lizenz.api.dart';

class LicenseRegisterTextField extends StatefulWidget {
  const LicenseRegisterTextField({Key? key}) : super(key: key);

  @override
  State<LicenseRegisterTextField> createState() =>
      _LicenseRegisterTextFieldState();
}

class _LicenseRegisterTextFieldState extends State<LicenseRegisterTextField> {
  late TextEditingController _textController;


  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: "");

    print(_textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoTextField(
        controller: _textController,
        keyboardType: TextInputType.text,
        autocorrect: false,
        placeholder: "Lizenz",
        maxLines: 1,
        decoration: BoxDecoration(
            border: Border.all(
          width: 0.8,
          color: CupertinoColors.systemBlue,
        )),
        onSubmitted: (value) async {
          setState(() {
            _textController.text = value;
          });
          var m = await LizenzApi.isVerified(value);

          if (m == true) {
            // true
            HiveHelper.putValueBool(
                box: "settings", key: "verified", value: true);

            showCupertinoDialog(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                      title: const Text("Erfolgreich aktiviert"),
                      content: const Text("Lizenz wurde erfolgreich aktiviert, die App kann nun genutzt werden"),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text("Schließen"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ));
          } else {
            showCupertinoDialog(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                      title: const Text("Error"),
                      content: const Text(
                          "Lizenz konnte nicht aktiviert werden, probieren sie eine andere Lizenz aus"),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text("Schließen"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ));
          }
        },
      ),
    );
  }
}
