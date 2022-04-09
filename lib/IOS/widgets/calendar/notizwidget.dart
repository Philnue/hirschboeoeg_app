import 'package:flutter/cupertino.dart';

class NotizWidget extends StatelessWidget {
  const NotizWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: width * 0.1,
            child: const FittedBox(
                fit: BoxFit.contain,
                child: Icon(CupertinoIcons.arrow_right_to_line_alt)),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: width * 0.55,
            height: 50,
            child: Container(
              child: Text(
                text,
                maxLines: 2,
              ),
            ),
          ),
          Container(
            height: 50,
            width: width * 0.28,
            child: FittedBox(
              fit: BoxFit.contain,
              child: CupertinoButton(
                  alignment: Alignment.centerLeft,
                  child: const Text("...mehr"),
                  onPressed: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                              title: const Text("Notiz"),
                              content: Text(text),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text("Schließen"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
