import 'package:boeoeg_app/widgets/aetmertext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AemterWidget extends StatefulWidget {
  const AemterWidget({Key? key}) : super(key: key);

  @override
  State<AemterWidget> createState() => _AemterWidgetState();
}

class _AemterWidgetState extends State<AemterWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Ämter:",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 69, 13, 13)),
        ),
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AemterText(text: "Alpha:"),
                  const AemterText(
                    text: "Daniel Lauer",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AemterText(text: "Beta:"),
                  AemterText(
                    text: "Philipp Nüßlein",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AemterText(text: "Schriftführer:"),
                  AemterText(
                    text: "Dennis Hofmann",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AemterText(text: "Finanzen:"),
                  AemterText(
                    text: "Uwe Ziefle",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Alpha :",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Daniel Lauer",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
