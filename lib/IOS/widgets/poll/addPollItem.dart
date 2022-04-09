import 'package:boeoeg_app/classes/Api/abstimmung.api.dart';
import 'package:boeoeg_app/classes/hiveHelper.dart';
import 'package:flutter/cupertino.dart';

class AddPoll extends StatefulWidget {
  const AddPoll({Key? key}) : super(key: key);
  static const routeName = '/addPoll';

  @override
  State<AddPoll> createState() => _AddPollState();
}

class _AddPollState extends State<AddPoll> {
  bool initvalue = false;
  int id = 0;

  late TextEditingController _frageController;
  late TextEditingController _titleController;
  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _frageController = TextEditingController(text: "");
    _titleController = TextEditingController(text: "");
  }

  //HttpHelper httpHelper = HttpHelper();
  //id = Hive.box("settings").get("id");
  //initvalue = httpHelper.getTerminAbstimmungByPersonAndTermin(path: Constants.getTerminAbstimmungByMitgliedAnTermin, terminId: arg.termin_id, mitgliedId: id)
  DateTime selectedDateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          "Abstimmung starten",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 20,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField(
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  placeholder: "Title",
                  autocorrect: false,
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 0.5,
                    color: CupertinoColors.systemBlue,
                  )),
                  onSubmitted: (value) {
                    setState(() {
                      _titleController.text = value;
                    });
                  },
                ),
              ),
            ),
            Flexible(
              flex: 40,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField(
                  controller: _frageController,
                  keyboardType: TextInputType.multiline,
                  textDirection: TextDirection.ltr,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.5,
                      color: CupertinoColors.systemBlue,
                    ),
                  ),
                  placeholder: "Frage",
                  maxLines: 10,
                  autocorrect: false,
                  onSubmitted: (value) {
                    setState(() {
                      _frageController.text = value;
                    });
                  },
                ),
              ),
            ),
            const Flexible(
              flex: 15,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Ablaufdatum:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 20,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: ((value) {
                  selectedDateTime = value;
                }),
                dateOrder: DatePickerDateOrder.dmy,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoButton(
                color: CupertinoColors.systemBlue,
                child: const Text(
                  "Abstimmung hinzufügen",
                  style: TextStyle(
                    fontSize: 20,
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: const Text("Abstimmung hinzufügen"),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text("Ja"),
                          onPressed: () {
                            int id =
                                HiveHelper.currentId;
                            AbstimmungApi.addAbstimmung(
                              mitglied_id: id,
                              frage: _frageController.text,
                              title: _titleController.text,
                              ablaufdatum:
                                  selectedDateTime.toString().substring(0, 10),
                            );

                            Navigator.of(context).pop();

                            //!  ganz löschen
                          },
                        ),
                        const CupertinoDialogAction(
                          child: Text("Nein"),
                          isDestructiveAction: true,
                        ),
                      ],
                      content: Text(_frageController.text),
                    ),
                  ).then(
                    (value) {
                      if (value == "yes") {
                        Navigator.of(context).pop();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
