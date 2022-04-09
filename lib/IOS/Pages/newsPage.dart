import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);
  static const routeName = '/news';

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Alle Neuigkeiten",
        ),
        border: Border(
            bottom: BorderSide(
          color: Theme.of(context).dividerColor,
        )),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Neuigkeiten",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Text("App wurde offiziel hochgeladen"),
              ]),
        ),
      ),
    );
  }
}
